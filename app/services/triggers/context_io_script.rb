require 'json'
require 'openssl'
require 'base64'
require 'ostruct'

class ContextIOTrigger < TransactionScript

  def run(inputs)
    secret_key = 'AGDc0NnvjJicuwaA'
    contextio = ContextIO.new('hmsdfr9u', secret_key)
    account_id = inputs.account_id
    account = contextio.accounts[account_id]

    gather_message_info(inputs, account)
  end





  def gather_message_info(inputs, account)

  end


end
