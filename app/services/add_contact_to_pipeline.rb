class AddContactToPipeline < TransactionScript
  def run(params)
    result = ContactPipelines.create(params)
    return success(contact: result)
  end
end
