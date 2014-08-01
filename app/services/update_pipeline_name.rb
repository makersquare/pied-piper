class UpdatePipelineName < TransactionScript
  def run(params)
    return failure(:name_nil) if params[:name].nil?
    name = params[:name].strip
    return failure(:name_empty) if name.length == 0
    return failure(:name_taken) unless Pipeline.create(name: name).valid?

    pipeline = Pipeline.update(params[:id], name: params[:name])

    return success(:data => pipeline)
  end
end