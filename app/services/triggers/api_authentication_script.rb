require 'json'
require 'openssl'
require 'base64'
require 'ostruct'

class ApiConversionScript < TransactionScript
  def run(inputs)
    webhook_id = #pre-defined webhook id from creation
    authenticate(inputs)
    confirm_type(inputs, webhook_id)
  end

  def authenticate(alert)
    unless (alert.signature == Base64.encode64(OpenSSL::HMAC.digest(
      OpenSSL::Digest::Digest.new('sha256'), @secret_key,
      body.timestamp+'.'+body.token)).strip())

      failure error: 'Context.io notification authentication failure'
    end
  end

  def confirm_type(alert, webhook_id)
    unless alert.webhook_id == webhook_id
      failure error: 'connect io webhook_id not recognized'
    end
  end

end
