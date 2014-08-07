class CreateStage < TransactionScript
  def run(params)

    return failure(:name_nil) if params[:name].nil?
    name = params[:name].strip
    return failure(:name_empty) if name.length == 0

    pipeline = Pipeline.find(params[:pipeline_id])
    stage_row = pipeline.stages.create(:name=>params[:name], :description=>params[:description], :pipeline_location=>params[:pipeline_location])
    return success(:data => stage_row)
  end
end

#required params = {name: blah, pipeline_id: pipeline_id, pipeline_location: plocation}
# params = {name: 'Andrew', description: nil, pipeline_id: 1, pipeline_location: 1}
