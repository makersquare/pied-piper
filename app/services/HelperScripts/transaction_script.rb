require 'ostruct'

# Example TransactionScript
#
# def SomeScript < TransactionScript
#
#   def run(inputs)
#     failure(:some_error) if something.invalid?
#     failure(:some_error_2, someData) if something2.invalid?
#     success(data: someData)
#   end
#
#   private # helper methods
#   def invalid?
#   end
#
# end

class TransactionScript

  def self.run(*inputs)
    self.new.run(*inputs)
  end

  def failure(error_sym, data={})
    OpenStruct.new(data.merge(error: error_sym, success?: false))
  end

  def success(data={})
    OpenStruct.new(data.merge(success?: true))
  end

  def sanitize_user_data(user_json)
    user_json.delete "oath_token"
    user_json.delete "created_at"
    user_json.delete "updated_at"
    user_json.delete "oath_expires_at"
    user_json.delete "webhook_id"
    user_json.delete "uid"

    return user_json
  end

end

