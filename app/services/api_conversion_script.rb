require 'ostruct'

class ApiConversionScript < TransactionScript
  def run(inputs)
    unless inputs.is_a?(Hash)
      return failure 'Api POST request formatted incorrectly'
    end
    return success ({ alert: inputs })
  end
end

