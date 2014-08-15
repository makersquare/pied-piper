include ContextioHelper

class AddUserToContextio < TransactionScript
  def run(user)
    name = user.name.split(' ')
    account = ContextioHelper.create_new_account(email: user.email, first_name: name[0], last_name: name[1..-1].join(' '))
    ContextioHelper.create_new_source(account: account, email: user.email, server: 'imap.gmail.com', username: user.email, use_ssl: 1, port: 993, type:'IMAP', options:{provider_refresh_token: user.oath_token})


  #this finds all the contacts by selecting the from section of the emails
    contacts = account.messages.map{ |x|x.from }.uniq
    contacts.each{ |contact| CreateContact.run(contact) }

    webhook = ContextioHelper.create_webhook({ user:user, options:{ sync_period:'immediate' }})
    return failure webhook['error'] unless webhook['success']
    return success user
  end
end
