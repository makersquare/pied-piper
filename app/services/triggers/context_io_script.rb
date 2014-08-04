
class ContextIOTrigger < TransactionScript

  def run(inputs)
    secret_key = inputs.secret_key
    contextio = ContextIO.new('hmsdfr9u', secret_key)
    account_id = inputs.alert.account_id
    account = contextio.accounts[account_id]

    message = get_message(inputs, account)

    return failure error: 'message content missing' unless message.is_a?(ContextIO::Message)

    text = select_message_text(message)

    return failure text['error'] unless text['error'].nil?
    return failure error: 'message content not a string' unless text.is_a?(String)

    return success ({ alert: inputs.alert, secret_key: secret_key  })
  end

  def get_message(inputs, account)
    message_id = inputs.message_data['message_id']
    account.messages[message_id]
  end

  def select_message_text(message)
    begin
      message.body_parts.where(type: 'text/plain').first.content
    rescue
      error:'message not formatted correctly'
    end
  end



end
