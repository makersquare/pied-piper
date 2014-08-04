class UpdateContactBox < TransactionScript
  def run(params)
    # Updates a contact's box info
    b = Box.where('contact_id = ?', params[:contact_id].to_i).first
    b.pipeline_id = params[:pipeline_id] || b.pipeline_id
    b.stage_id = params[:stage_id] || b.stage_id
    b.pipeline_location = params[:pipeline_location] || b.pipeline_location

    b.contact.name = params[:name] || b.contact.name
    b.contact.email = params[:email] || b.contact.email
    b.contact.phoneNum = params[:phoneNum] || b.contact.phoneNum
    b.contact.city = params[:city] || b.contact.city

    field = b.fields.find(params[:field_id])
    field.field_name = params[:field_name] || field.field_name
    field.field_type = params[:field_type] || field.field_type

    field_value = b.box_fields.find(params[:box_field_id])
    field_value.value = params[:value] || field_value.value

    notes = b.notes.find(params[:notes_id])
    notes.notes = params[:notes] || notes.notes

    b.save
    b.contact.save
    b.contact.save
    field.save
    field_value.save
    notes.save

    c = b.contact
    f = b.fields
    fv = b.box_fields
    n = b.notes
    return success box: b, contact: c, fields: f, field_values: fv, notes: n
  end
end
