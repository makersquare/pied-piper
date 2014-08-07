class RetrievePipeline < TransactionScript
  def run(pipeline_id)
    pipeline_entity = Pipeline.find(pipeline_id)
    return success(:data => pipeline_entity)
  end
end