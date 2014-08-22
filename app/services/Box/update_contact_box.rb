# Master TXS for updating information associated with a contact
# box.  Calls helper TXS to:
# 1. Update contact's primary information
# 2. Update contact's box field values
# 3. Update contact's stage
# 4. Update contact's note
class UpdateContactBox < TransactionScript
  def run(params)

    if params[:contact_id].nil?
      return failure(:no_contact_id_passed)
    end

    if params[:pipeline_id].nil?
      return failure(:no_pipeline_id_passed)
    end

    UpdateContactInfo.run(params)
    UpdateContactStage.run(params)

    # Loop through box_field array to update field value by box_field id
    if params[:field_values]
      field_vals = params[:field_values]
      field_vals.each do |field_val|
        UpdateContactFieldValues.run({field_values: field_val})
      end
    end

    # Loop through notes array to update note by note id
    if params[:notes]
      notes = params[:notes]
      notes.each do |note|
        UpdateContactNote.run({note: note})
      end
    end

    # Retrieve the updated box to return as success object
    b = Box.where(contact_id: params[:contact_id], pipeline_id: params[:pipeline_id]).first
    c = b.contact
    f = b.fields
    fv = b.box_fields
    n = b.notes
    return success box: b, contact: c, fields: f, field_values: fv, notes: n
  end
end
