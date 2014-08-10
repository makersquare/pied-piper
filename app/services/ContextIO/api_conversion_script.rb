require 'ostruct'
# This TX script checks to make sure the api post is either a json or
# a hash and if it is a json then it parses it into a hash
class ApiConversionScript < TransactionScript
  def run(inputs)

#inputs will be the raw params from the api post
    inputs = check_for_json(inputs) if inputs.is_a?(String)

#either inputs is a hash, is converted into a hash or it cannot
#be converted into a hash and this will return a string
    unless inputs.is_a?(Hash)
      return failure 'Api POST request formatted incorrectly'
    end

    return success alert: inputs
  end
end

def check_for_json(inputs)
  begin
    JSON.parse(inputs)
  rescue
    'inputs not JSON object'
  end
end
