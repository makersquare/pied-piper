class TransactionScript

  def self.run(inputs)
    self.new.run(inputs)
  end

  def failure(error_name)
    return {success?: false, error: error_name}
  end

  def success(data)
    return {:success? => true, :data => data}
  end
end
