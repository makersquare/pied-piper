class RemoveUserPipeline < TransactionScript
  def run(params)
    #Not bothering to check for data integrity here, we should control that
    # on the frontend
    user_id = params[:user_id]
    pipeline_id = params[:id]
    pipeline_entity = PipelineUser.find_by(user_id: user_id, pipeline_id: pipeline_id)
    
    return failure(:user_not_in_pipeline) if pipeline_entity.nil?
    
    begin
      result = PipelineUser.delete(pipeline_entity.id)
      return success(:data => result)
    rescue
      return failure(:problem_adding_user)
    end
  end
end