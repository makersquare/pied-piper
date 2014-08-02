class CreateBox < TransactionScript
  def run(params)
    b = Box.create(params)
    c = Contact.find(params[:contact_id])
    c.save
    return success box: b, contact: c
  end
end
