class DestroyPipeline < TransactionScript
  def run(pipeline_id)
    #We don't need to do a non-admin check here because we can 
    #control access to the rails controller method (do validaton there)

    #This method will destroy the pipeline row, along with
    #associated stages, fields, the boxes that belong to each
    #stage, the box-fields which belong to a box, the history and
    #notes which belong to the box

    pipeline_entity = Pipeline.find(pipeline_id)
    return failure(:pipeline_not_trashed) unless pipeline_entity.trashed
    begin 
      result = Pipeline.destroy(pipeline_id)
      return success(:data => result)
    rescue Exception
      return failure(:problem_destroy_pipeline, :error_data => e)
    end
  end
end