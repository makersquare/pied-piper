class AddContactToPipeline < TransactionScript
  def run(params)
    # Add contact to a pipeline via the ContactPipelines table
    result = Box.create(params)
    # if stage id == null then populate with first stage # pipeline.stages.first
    return success(contact: result)
  end
end
