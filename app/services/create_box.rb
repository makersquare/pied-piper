class CreateBox < TransactionScript
  def run(params)
    b = Box.create(params)
    return success box: b
  end
end
