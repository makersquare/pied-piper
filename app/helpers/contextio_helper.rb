require 'openssl'
require 'base64'

module ContextioHelper

  def self.contextio_signin
    ContextIO.new(ENV['CONTEXTIO_APIKEY'], ENV['CONTEXTIO_SECRETKEY'])
  end

  def self.account_signin(identifier)
    contextio = ContextioHelper.contextio_signin
    contextio.accounts[identifier]
  end

  def self.account_email_signin(identifier)
    contextio = ContextioHelper.contextio_signin
    contextio.accounts.where(email:identifier).first
  end

  def self.create_new_account(user)
    contextio= ContextioHelper.contextio_signin
    contextio.accounts.create(email: user[:email], first_name: user[:first_name], last_name: user[:last_name])
  end

  def self.create_new_source(inputs)
    account = inputs[:account]
    account.sources.create(inputs[:email], inputs[:server], inputs[:username], inputs[:use_ssl], inputs[:port], inputs[:type], inputs[:options])#provider_refresh_token: inputs[:provider_refresh_token])
  end

  def self.authenticate(alert)

  #this hash is generated using the secret key, the timestamp and the token from the
  #notification using openssl and sha256 encryption
    our_hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, ENV['CONTEXTIO_SECRETKEY'], alert['timestamp'].to_s+alert['token'])

  #then we compare our generated has to the signature from the notification
    unless our_hash == alert['signature']
      return 'Context.io notification authentication failure'
    end

  #here we are testing the webhook id to confirm it is the correct notification and not
  #a duplicate webhook, or a webhook for a different function
    unless alert['webhook_id'] == ENV['CONTEXTIO_WEBHOOKID']
      return 'Context.io webhook id not recognized'
    end
  end

  def self.convert_json(inputs)
    begin
      inputs = JSON.parse(inputs)
    rescue
      return 'inputs not JSON object'
    end
    return inputs
  end

  def self.get_message(inputs)
    inputs[:account].messages[inputs[:message_id]]
  end

  def self.get_messages(inputs)
    account = inputs[:account]
    account.messages.where(
      from: inputs[:contact].email,
      date_after: inputs[:time]
      )
  end

  def self.select_message_text(message)
    begin
      { body: message.body_parts.where(type: 'text/plain').first.content,
        success:true }
    rescue
      { success:false }
    end
  end

  def self.parse_typeform(message)
  #these questions are the requirements for a contact entity we can move these out to be
  #altered later if we want


    questions = [
          'firstname',
          'first name',
          'last name',
          'name',
          'e-mail',
          'e-mail address',
          'email',
          'phone number',
          'phonenumber',
        ]
  #this downcases the message for easier parsing and removes > and \r characters
  #then we store the body in order to save it as a note later
    body = message.downcase.gsub(/>|\r/,'')

  #we split the body into an array of lines to parse it line by line and then split each
  #line into an array of words
    info = body.split(/\n/).map{|word| word.split(' ')}

  #we split each question into an array of words to compare it to the body
    questions = questions.map{|word| word.split(' ')}

    new_info = {}
  #we are storing the body text in the has to retrieve it for a note later
    new_info['body'] = body

  #cycle through the body to match the questions
    info.each_with_index do |sentence, index|
      if questions.include?(sentence)
        #we compare each array of question words to each array of words in the body then we
        #return the matching lines as a key to the value containing the next line
        new_info[sentence.join('')] = info[index+1][0].capitalize
      end
    end
  #return the body hash containing the name, body, email, and maybe the phone number
    new_info
  end

  def self.create_webhook(inputs)
  #this sets a new webhook to send an alert and check for a new contact every time there is
  #a new email
  #THIS NEEDS TO BE SET TO THE FINAL WEB ADDRESS
    site = "http://pied-piper-staging.herokuapp.com/contextio/webhook/#{ inputs[:user].id }"
    account = ContextioHelper.account_email_signin(inputs[:user].email)

    begin
      webhook = account.webhooks.create(site, site, inputs[:options])
    rescue
      return {success: false, error: webhook}
    end
    User.find_by(email:params[:user].email).update(webhook_id: webhook.webhook_id)

    {success: true , webhook: webhook}
  end
end
