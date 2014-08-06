class CreateContact < TransactionScript
  def run(params)
    result = Contact.create(params)
    if result
      # EmailDispatcher.run(result)
      UserMailer.new_contact_update(result).deliver
    end
    return success(contact: result)
  end
end
