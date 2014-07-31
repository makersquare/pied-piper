require 'pry-byebug'
class CreatePipelineScript < TransactionScript
  def run(params)
    return failure(:name_nil) if params[:name].nil?
    name = params[:name]
    # name = params[:name].strip
    return failure(:name_empty) if name.length == 0
    return failure(:name_taken) unless Pipeline.create(name: name).valid?

    pipeline = Pipeline.create(name: name)
    binding.pry
    return success(:data => pipeline)
  end
end
