# 1. Update contact's primary information
# 2. Update contact's box field values
# 3. Update contact's stage
# 4. Update contact's note
class UpdateContactBox < TransactionScript
  def run(params)
    # Updates a contact's box info
    b = Box.where(contact_id: params[:contact_id], pipeline_id: params[:pipeline_id]).first
    b.stage_id = params[:stage_id] || b.stage_id
    b.pipeline_location = params[:pipeline_location] || b.pipeline_location

    UpdateContactInfo.run(params)
    UpdateContactStage.run(params)

    # Loop through box_field array to update field value by box_field id
    if !params[:field_values].nil?
      field_vals = params[:field_values]
      field_vals.each do |field_val|
        UpdateContactFieldValues.run(params)

        # v = BoxField.find(field_val[:id])
        # v.update_column(:value, field_val[:value]) || v[:value]
      end
    end

    # Loop through notes array to update note by note id
    if !params[:notes].nil?
      notes = params[:notes]
      notes.each do |note|
        UpdateContactNote.run(params)
        # nt = Note.find(note[:id])
        # nt.update_column(:notes, note[:notes]) || nt[:notes]
      end
    end
    b.save
    # b.contact.save
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
