class TransactionScript

  # private
  def self.run(inputs)
    self.new.run(inputs)
  end

  def failure(error_name)
    return {success?: false, error: error_name}
  end

  def success(data)
    return {:success? => true}.merge({data: data})
  end

end
