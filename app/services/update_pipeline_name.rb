class UpdatePipelineName < TransactionScript
  def run(params)
    return failure(:name_nil) if params[:name].nil?
    name = params[:name].strip
    return failure(:name_empty) if name.length == 0

    begin
      pipeline = Pipeline.update!(params[:id], name: params[:name])
      return success(:data => pipeline)
    rescue Exception => e
      return failure(:name_taken, :error_data => e)
    end

  end
end
