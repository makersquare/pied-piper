include ContextioHelper
class DownloadContactScript < TransactionScript
#this will access the email address and download all contacts who have emailed or have been
#emailed by the user's email address
  def run(user)

  #this accesses context io and gets the correct account
    account = account_signin(user.email)

  #this finds all the contacts by selecting the from section of the emails
    contacts = account.messages.map{ |x|x.from }.uniq
    contacts.each{ |contact| CreateContact.run(contact) }
    webhook = create_webhook(user)
    return failure webhook['error'] unless webhook['success']

  #return the original user object
    return success (user)
  end
end
