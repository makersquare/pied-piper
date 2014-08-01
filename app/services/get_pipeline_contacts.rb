class GetPipelineContacts < TransactionScript
  def run(params)
    pipeline = Pipeline.find(params[:pipeline_id])
    contacts = Contact.find(params[:contact_id])
    contacts.boxes << b
    return success pipeline: pipeline, contacts: contacts
  end
end
