class CreateContact < TransactionScript
  def run(params)
    contact = Contact.create(params)
    result = contact
    return success(contact: result)
  end
end
