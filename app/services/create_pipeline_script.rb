require 'pry-byebug'
class CreatePipelineScript < TransactionScript
  def run(params)
    return failure(:name_nil) if params[:name].nil?
    name = params[:name]
    return failure(:name_empty) if name.length == 0
    # return failure(:name_taken) unless Pipeline.create(name: name).valid?

    begin
      pipeline = Pipeline.create!(name: name)
      return success(:data => pipeline)
    rescue Exception => e
      return failure(:name_taken, :error_data => e)
    end
  end
end
