class GetBoxByContactAndPipelineIds < TransactionScript
  def run(params)
    # Return a box associated with given contact and pipeline ids
    result = Box.first(:conditions=>["pipeline_id = ? AND contact_id = ?", params[:pipeline_id], params[:contact_id]])
    return success(box: result)
  end
end
