
class RetrieveMessageScript < TransactionScript

  def run(inputs)
    contextio = ContextIO.new(ENV['CONTEXTIO_APIKEY'], ENV['CONTEXTIO_SECRETKEY'])
    account = contextio.accounts[inputs.alert['account_id']]
    message = get_message(inputs, account)

    return failure 'message content missing' unless message.is_a?(ContextIO::Message)

    text = select_message_text(message)

    return failure 'message not formatted correctly' unless text[:success]
    return failure 'message content not a string' unless text[:body]is_a?(String)

    return success ({ alert: text[:body] })
  end

  def get_message(inputs, account)

    message_id = inputs.alert['message_data']['message_id']
    account.messages[message_id]

  end

  def select_message_text(message)
    begin
      { body: message.body_parts.where(type: 'text/plain').first.content,
        success:true }
    rescue
      { success:false }
    end
  end



end
