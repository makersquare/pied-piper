class UpdateContactBox < TransactionScript
  def run(params)
    # Updates a contact's box info
    b = Box.find(params[:box_id])
    c = Contact.find(params[:contact_id])
    f = Box.find(params[:box_id]).fields
    fv = Box.find(params[:box_id]).box_fields
    n = Box.find(params[:box_id]).notes
    return success box: b, contact: c, field: f, field_value: fv, notes: n
  end
end
