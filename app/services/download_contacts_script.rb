class DownloadContactScript < TransactionScript
  def run(inputs)
    contextio = ContextIO.new(ENV['CONTEXTIO_APIKEY'], ENV['CONTEXTIO_SECRETKEY'])
    account = contextio.accounts[ENV['CONTEXTIO_ACCOUNTID']]
    contacts = account.messages.map{|x|x.from}.uniq
    contacts.each{ CreateContact.run}



    return success (alert: text)
  end

  def create_webhook(inputs)

  end

  def select_message_text(message)
    begin
      message.body_parts.where(type: 'text/plain').first.content
    rescue
      'message not formatted correctly'
    end
  end

end
