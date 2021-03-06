class CreatePipelineScript < TransactionScript
# Need to add the creator of the pipeline to the PipelineUser table
# and give them a default email setting  
  def run(params)
    creator_id = params[:user_id]
    return failure(:name_nil) if params[:name].nil?
    name = params[:name]
    return failure(:name_empty) if name.length == 0

    begin
      pipeline = Pipeline.create!(name: name)
      AddUserPipeline.run(user_id: creator_id, id: pipeline.id)
      pipeline.stages.create(name: "Default", description: "", pipeline_location: 1)
      return success(:data => pipeline)
    rescue
      return failure(:name_taken)
    end
  end
end

