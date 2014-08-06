class DownloadContactScript < TransactionScript
  def run(user)
    contextio = ContextIO.new(ENV['CONTEXTIO_APIKEY'], ENV['CONTEXTIO_SECRETKEY'])
    account = contextio.accounts[user.email]
    contacts = account.messages.map{ |x|x.from }.uniq
    contacts.each{ |contact| CreateContact.run(contact) }
    webhook = create_webhook(user)
    return failure webhook['error'] unless webhook['success']
    return success (user)
  end

  def create_webhook(user)
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
