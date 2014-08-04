require 'ostruct'

class ApiConversionScript < TransactionScript
  def run(inputs)
    alert = confirm(inputs)
    unless alert.is_a?(OpenStruct)
      return failure error: 'failure to convert alert to OpenStruct'
    end
    return success ({ alert: alert })
  end

  def confirm(alert)
    if alert.alert.is_a?(Hash)
      OpenStruct.new(alert)
    end
  end
end

