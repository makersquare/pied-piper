class CreateContact < TransactionScript
  def run(params)
    result = Contact.create(params)
    return success(contact: result)
  end
end
