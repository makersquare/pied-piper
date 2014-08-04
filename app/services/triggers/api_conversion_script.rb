require 'json'
require 'openssl'
require 'base64'
require 'ostruct'

class ApiConversionScript < TransactionScript
  def run(inputs)
    confirm(inputs)
  end

  def confirm(alert)
    if notification_hash.is_a(Hash)
      OpenStruct.new(alert)
    else
      failure error: 'failure to convert notificaion to OpenStruct'
    end
  end

end
