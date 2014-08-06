class UpdateContactBox < TransactionScript
  def run(params)
    # Updates a contact's box info
    # binding.pry
    b = Box.where('contact_id = ?', params[:contact_id].to_i).first
    b.pipeline_id = params[:pipeline_id] || b.pipeline_id
    b.stage_id = params[:stage_id] || b.stage_id
    b.pipeline_location = params[:pipeline_location] || b.pipeline_location

    b.contact.name = params[:name] || b.contact.name
    b.contact.email = params[:email] || b.contact.email
    b.contact.phoneNum = params[:phoneNum] || b.contact.phoneNum
    b.contact.city = params[:city] || b.contact.city

    field = Field.where('pipeline_id = ?', params[:pipeline_id]).first
    field.field_name = params[:field_name] || field.field_name if !field.nil?
    field.field_type = params[:field_type] || field.field_type if !field.nil?

    field_value = BoxField.where('box_id = ?', b.id).first
    field_value.value = params[:value] || field_value.value if !field_value.nil?

    notes = Note.where('box_id = ?', b.id).first
    notes.notes = params[:notes] || notes.notes if !notes.nil?

    b.save
    b.contact.save
    field.save if !field.nil?
    field_value.save if !field_value.nil?
    notes.save if !notes.nil?

    c = b.contact
    f = b.fields
    fv = b.box_fields
    n = b.notes
    return success box: b, contact: c, fields: f, field_values: fv, notes: n
  end
end
