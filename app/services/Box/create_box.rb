class CreateBox < TransactionScript
  # Creates an empty box
  def run(params)
    b = Box.create(params)
    return success box: b
  end
end
