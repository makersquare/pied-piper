require 'openssl'
require 'base64'

#This Script authenticates the notifications to confirm that they are
#from Contextio.

class ApiAuthenticationScript < TransactionScript
  def run(alert)
  #this selects the original params from the transaction success
  #return
    inputs = alert.alert

  #inputs ['signature'] is the authentication hash we are using
  #to confirm the the notification is authentic
  #here we test first to see if it is nil
    if inputs['signature'].nil?
      return failure 'Context.io authentication signature is nil'
    end

  #the webhook id is obtained when we create the webhook
    error = authenticate(inputs)

    return failure error if !error.nil?

    return success(alert: inputs)
  end



  def authenticate(alert)

  #this hash is generated using the secret key, the timestamp and the token from the
  #notification using openssl and sha256 encryption
    our_hash = OpenSSL::HMAC.hexdigest(OpenSSL::Digest::SHA256.new, ENV['CONTEXTIO_SECRETKEY'], alert['timestamp'].to_s+alert['token'])

  #then we compare our generated has to the signature from the notification
    unless our_hash == alert['signature']
      return 'Context.io notification authentication failure'
    end

  #here we are testing the webhook id to confirm it is the correct notification and not
  #a duplicate webhook, or a webhook for a different function
    unless alert['webhook_id'] == ENV['CONTEXTIO_WEBHOOKID']
      return 'Context.io webhook id not recognized'
    end
  end
end
