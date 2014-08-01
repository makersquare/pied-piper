class GetContactsByPipelineId < TransactionScript
  def run(params)
    # Gets all contacts with a given pipeline id
    result = Box.find(:pipeline_id =>params[:pipeline_id]).contacts
    return success contacts: result
  end
end
