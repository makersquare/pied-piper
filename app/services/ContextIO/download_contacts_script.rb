class DownloadContactScript < TransactionScript
#this will access the email address and download all contacts who have emailed or have been
#emailed by the user's email address
  def run(user)

  #this accesses context io and gets the correct account
    contextio = ContextIO.new(ENV['CONTEXTIO_APIKEY'], ENV['CONTEXTIO_SECRETKEY'])
    account = contextio.accounts[user.email]

  #this finds all the contacts by selecting the from section of the emails
    contacts = account.messages.map{ |x|x.from }.uniq
    contacts.each{ |contact| CreateContact.run(contact) }
    webhook = create_webhook(user)
    return failure webhook['error'] unless webhook['success']

  #return the original user object
    return success (user)
  end

  def create_webhook(user)
  #this sets a new webhook to send an alert and check for a new contact every time there is
  #a new email
    site = 'contextio/webhook/:#{user.id}'
    begin
      webhook = account.webhook.create(site, site, sync_period:'immediate')
    rescue
      return {success: false, error: webhook}
    end
    end
    user.webhook_id = webhook.webhook_id
    success: true
  end

end
