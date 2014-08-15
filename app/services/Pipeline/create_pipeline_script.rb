class CreatePipelineScript < TransactionScript
# Need to add the creator of the pipeline to the PipelineUser table
# and give them a default email setting  
  def run(params)
    creator_id = params[:id]

    return failure(:name_nil) if params[:name].nil?
    name = params[:name]
    return failure(:name_empty) if name.length == 0
    # return failure(:name_taken) unless Pipeline.create(name: name).valid?

    begin
      pipeline = Pipeline.create!(name: name)
      AddUserPipeline.run(user_id: creator_id, id: pipeline.id)
      return success(:data => pipeline)
    rescue
      return failure(:name_taken)
    end
  end
end