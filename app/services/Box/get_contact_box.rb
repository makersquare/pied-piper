class GetContactBox < TransactionScript
  def run(params)
    # Returns a contact's box, with info associated with the pipeline stage
    b = Box.where('contact_id = ?', params[:contact_id].to_i)
    if b.empty?
      return failure :no_box_found
    end
    c = Box.find(b.first.id).contact
    f = Box.find(b.first.id).fields
    fv = Box.find(b.first.id).box_fields
    n = Box.find(b.first.id).notes
    p = Pipeline.find(b.first.pipeline_id)
    return success box: b, contact: c, fields: f, field_values: fv, notes: n, pipeline: p
  end
end
