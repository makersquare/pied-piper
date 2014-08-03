class GetContactBox < TransactionScript
  def run(params)
    # Returns a contact's box, with info associated with the pipeline stage
    b = Box.find(params[:box_id])
    c = Contact.find(params[:contact_id])
    f = Box.find(params[:box_id]).fields
    fv = Box.find(params[:box_id]).box_fields
    n = Box.find(params[:box_id]).notes
    return success box: b, contact: c, field: f, field_value: fv, notes: n
  end
end
