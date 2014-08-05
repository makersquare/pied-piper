class GetContactsByPipelineId < TransactionScript
  def run(params)
    # Gets all contacts with a given pipeline id
    binding.pry
    result = Pipeline.find(params[:pipeline_id]).contacts
    return success contacts: result
  end
end

Box.where('pipeline_id = ?', 1)