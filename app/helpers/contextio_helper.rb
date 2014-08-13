require 'openssl'
require 'base64'

module ContextioHelper
  def contextio_signin
    ContextIO.new(ENV['CONTEXTIO_APIKEY'], ENV['CONTEXTIO_SECRETKEY'])
  end

  def create_new_account(user)
    contactio= contextio_signin
    contextio.accounts.new(email: user[:email], first_name: user[:first_name], last_name: user[:last_name])
  end

  def create_new_source(params)
    account = params[:account]
    account.sources.create(email: params[:email], server: params[:server], username: params[:username], use_ssl: params[:use_ssl], port: params[:port], type:params[:type], provider_refresh_token: params[:provider_refresh_token])
  end

  def authenticate(alert)

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

  def check_for_json(inputs)
    begin
      inputs = JSON.parse(inputs)
    rescue
      return 'inputs not JSON object'
    end
    return inputs
  end

end
