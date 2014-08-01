class CreateBox < TransactionScript
  def run(params)
    b = Box.new(params[:contact_id], params[])
    c = Contact.find(params[:contact_id])
    c.boxes << b
    c.save
    return success box: b, contact: c
  end
end
