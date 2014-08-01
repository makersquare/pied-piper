class GetBox < TransactionScript
  def run(params)
    box = Box.find(params[:contact_id])
    result = contact
    return success(contact: result)
  end
end
