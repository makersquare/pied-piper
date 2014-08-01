require 'json'
require 'openssl'
require 'Base64'
require 'ostruct'


# require 'contextio'

# contextio = ContextIO.new('hmsdfr9u', 'AGDc0NnvjJicuwaA')

# account = contextio.accounts.where(email: 'devpiedpiper@gmail.com').first

# account.messages.where(from: 'jeredmccullough@gmail.com')


class ContextIOTrigger < TransactionScript
  def initialize(webhook_id, account_id, api_key, secret_key)
    @webhook_id = webhook_id
    @account_id = account_id
    @api_key = api_key
    @secret_key = secret_key
  end

  def run(inputs)
    notification_hash = parse_notification
    notification_hash.authenticate
    notification_hash.comfirm_type
    notification_hash.gather_message_info
  end

  def parse_notification(alert)
    notification_hash = JSON.parse(alert)
    unless notification_hash.is_a(Hash)
      failure error: 'failure to convert notificaion to Hash'
    end
  end

  def authenicate(alert)
    notification = OpenStruct.new(alert)
    unless (notification.signature == Base64.encode64(OpenSSL::HMAC.digest(
      OpenSSL::Digest::Digest.new('sha256'), @secret_key,
      body.timestamp+'.'+body.token)).strip())

      failure error: 'Context.io notification authentication failure'
    end
  end

  def confirm_type(notification)
    unless notification.webhook_id == @webhook_id
      failure error: 'connect io webhook_id not recognized'
    end
  end

  def gather_message_info

  end


end
