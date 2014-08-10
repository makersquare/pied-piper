class UpdatePipelineName < TransactionScript
  def run(params)
    return failure(:name_nil) if params[:name].nil?
    name = params[:name].strip
    return failure(:name_empty) if name.length == 0

    pipeline = Pipeline.find(params[:id])
    if pipeline.update(name: params[:name])
      return success(:data => pipeline)
    else
      return failure(:name_taken, :error_data => pipeline.errors.first)
    end

  end
end
