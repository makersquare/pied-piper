class DownloadContactScript < TransactionScript
  def run(inputs)
    contextio = ContextIO.new(ENV['CONTEXTIO_APIKEY'], ENV['CONTEXTIO_SECRETKEY'])
    account = contextio.accounts[ENV['CONTEXTIO_ACCOUNTID']]
    message = get_message(inputs, account)

    return failure 'message content missing' unless message.is_a?(ContextIO::Message)

    text = select_message_text(message)

    return failure text['error'] unless text['error'].nil?
    return failure 'message content not a string' unless text.is_a?(String)

    return success (alert: text)
  end

  def get_message(inputs, account)

    message_id = inputs.alert['message_data']['message_id']
    account.messages[message_id]

  end

  def select_message_text(message)
    begin
      message.body_parts.where(type: 'text/plain').first.content
    rescue
      'message not formatted correctly'
    end
  end

end
