class GetAllContacts < TransactionScript
  def run
    contact = Contact.all
    result = contact
    return success(contact: result)
  end
end
