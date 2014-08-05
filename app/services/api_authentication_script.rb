require 'openssl'
require 'base64'

class ApiAuthenticationScript < TransactionScript
  def run(inputs)
    if inputs[:signature].nil?
      return failure 'Context.io authentication signature is nil'
    end
    secret_key = 'AGDc0NnvjJicuwaA'
    webhook_id = '53dc3db6b4810f6c699076d3'
    error = authenticate(inputs, webhook_id, secret_key)

    return failure error if !error.nil?

    return success({ alert: inputs, secret_key: secret_key })
  end



  def authenticate(alert, webhook_id, secret_key)
    our_hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, secret_key, alert[:timestamp].to_s+alert[:token])

    unless our_hash == alert[:signature]
      return 'Context.io notification authentication failure'
    end

    unless alert[:webhook_id] == webhook_id
      return 'Context.io webhook id not recognized'
    end

  end


end
