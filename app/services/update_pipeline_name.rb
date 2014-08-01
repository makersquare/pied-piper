class UpdatePipelineName < TransactionScript
  def run(params)
    return failure(:name_nil) if params[:name].nil?
    name = params[:name].strip
    return failure(:name_empty) if name.length == 0

    existing_pipeline = Pipeline.find_by(name: params[:name])
    return failure(:name_taken) unless existing_pipeline.nil?

    pipeline = Pipeline.update(params[:id], name: params[:name])
    return success(:data => pipeline)
  end
end
