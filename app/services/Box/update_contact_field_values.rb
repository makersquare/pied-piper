# Updates a contact's field values based off of
# fields hash passed in.
class UpdateContactFieldValues < TransactionScript
  def run(params)

    if params[:contact_id].nil?
      return failure(:no_contact_id_passed_in)
    end

    contact = Contact.where(id: params[:contact_id]).first

    if contact.nil?
      return failure(:invalid_contact_id)
    end

    if params[:field_id].nil?
      return failure(:no_field_id_passed_in)
    end

    boxfield = BoxField.where(field_id: params[:field_id]).first

    if boxfield.nil?
      return failure(:invalid_boxfield_field_id)
    end

    if params[:box_field].nil?
      return failure(:no_boxfield_info_passed)
    end

    boxfield.update(params[:box_field])

    return success({boxfield: boxfield})
  end
end
