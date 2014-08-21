# Updates a contact's information based off of
# contacts hash passed in.
class UpdateContactInfo < TransactionScript
  def run(params)
    if params[:contact_id].nil?
      return failure(:no_contact_id_passed_in)
    end

    contact = Contact.where(id: params[:contact_id]).first

    if contact.nil?
      return failure(:invalid_contact_id)
    end

    if params[:contact].nil?
      return failure(:no_contact_info_passed)
    end

    contact.update(params[:contact])

    return success({contact: contact})
  end
end