# Updates a contact's field values based off of
# fields hash passed in.
class UpdateContactFieldValues < TransactionScript
  def run(params)
    if params[:field_values].nil?
      return failure(:no_field_value_info_passed)
    end

    boxfield = BoxField.where(id: params[:field_values][:id]).first

    if boxfield.nil?
      return failure(:invalid_field_value_id)
    end

    boxfield.update(params[:field_values])

    return success({boxfield: boxfield})
  end
end
