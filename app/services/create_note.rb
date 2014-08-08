class CreateNote < TransactionScript
  def run(params)
  	box = Box.find_by(contact_id: params[:contact_id])
  	contact = Contact.find(params[:contact_id])
    pipeline = Pipeline.find(params[:pipeline_id])
    notes = box.notes.create(:notes=>params[:notes], :user_id=>params[:user_id])
    return success(:data => notes, :contact=> contact, :box=> box, :pipeline => pipeline)
  end
end

#required params = {name: blah, pipeline_id: pipeline_id, pipeline_location: plocation}
# params = {name: 'Andrew', description: nil, pipeline_id: 1, pipeline_location: 1}
