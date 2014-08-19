# 1. Update contact's primary information
# 2. Update contact's box fields
# 3. Update contact's stage
# 4. Update contact's note
class UpdateContactBox < TransactionScript
  def run(params)
    # Updates a contact's box info
    b = Box.where(contact_id: params[:contact_id], pipeline_id: params[:pipeline_id]).first
    b.stage_id = params[:stage_id] || b.stage_id
    b.pipeline_location = params[:pipeline_location] || b.pipeline_location

    UpdateContactInfo.run(params)

    if params.include?(:status)
      UpdateBoxStage.run(params)
    end
    # field = Field.where('pipeline_id = ?', params[:pipeline_id]).first
    # field.field_name = params[:field_name] || field.field_name if !field.nil?
    # field.field_type = params[:field_type] || field.field_type if !field.nil?

    # Loop through box_field array to update field value by box_field id
    if !params[:field_values].nil?
      field_vals = params[:field_values]
      field_vals.each do |field_val|
        v = BoxField.find(field_val[:id])
        v.update_column(:value, field_val[:value]) || v[:value]
      end
    end

    # Loop through notes array to update note by note id
    if !params[:notes].nil?
      notes = params[:notes]
      notes.each do |note|
        nt = Note.find(note[:id])
        nt.update_column(:notes, note[:notes]) || nt[:notes]
      end
    end
    b.save
    b.contact.save
    # field.save if !field.nil?
    # field_value.save if !field_value.nil?
    # notes.save if !notes.nil?

    c = b.contact
    f = b.fields
    fv = b.box_fields
    n = b.notes
    return success box: b, contact: c, fields: f, field_values: fv, notes: n
  end
end
