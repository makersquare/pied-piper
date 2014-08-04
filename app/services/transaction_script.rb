require 'ostruct'
require 'pry-byebug'
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
end

