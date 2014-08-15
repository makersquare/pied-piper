require 'ostruct'
include ContextioHelper


class CreateUser < TransactionScript
  def run(params)
    params = OpenStruct.new(params) if params.is_a?(Hash)
    return failure 'User already in database' if user_already_exists?(params)
    result = User.create({
      name: params.name,
      email: params.email,
      provider: params.provider,
      oauth_token: params.oauth_token,
      oauth_expires_at: params.oauth_expires_at,
      webhook_id: params.webhook_id
      })

    if result
      UserMailer.registration_email(result).deliver
    end

#this adds the user to Contextio and creates a webhook and downloads contacts
    user = result
    name = user.name.split(' ')
    account = ContextioHelper.create_new_account(email: user.email, first_name: name[0], last_name: name[1..-1].join(' '))
    ContextioHelper.create_new_source(account: account, email: user.email, server: 'imap.gmail.com', username: user.email, use_ssl: 1, port: 993, type:'IMAP', options:{provider_refresh_token: user.oath_token})


  #this finds all the contacts by selecting the from section of the emails
    contacts = account.messages.map{ |x|x.from }.uniq
    contacts.each{ |contact| CreateContact.run(contact) }

    webhook = ContextioHelper.create_webhook({ user:user, options:{ sync_period:'immediate' }})
    return failure webhook['error'] unless webhook['success']

    return success(user: result)
  end

  def user_already_exists?(params)
    email = User.find_by(email: params.email)
    name = User.find_by(name: params.name)
    if name.nil? && email.nil?
      return false
    end
    return true
  end
end
