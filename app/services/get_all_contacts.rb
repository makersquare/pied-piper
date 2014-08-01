class GetAllContacts < TransactionScript
  def run
    contact = Contact.create(params)
    result = contacts
    return success(contact: result)
  end
end
