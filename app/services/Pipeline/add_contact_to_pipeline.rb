class AddContactToPipeline < TransactionScript
  def run(params)
    # Add contact to a pipeline via the ContactPipelines table
    result = Box.create(params)
    return success(contact: result)
  end
end
