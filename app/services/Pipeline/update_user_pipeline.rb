class UpdateUserPipeline < TransactionScript
  def run(params)
    #Not bothering to check for data integrity here, we should control that
    # on the frontend
    user_id = params[:user_id]
    pipeline_id = params[:pipeline_id]
    admin = params[:pipeline_admin]
    pipeline_entity = PipelineUser.find_by(user_id: user_id, pipeline_id: pipeline_id)
    
    return failure(:no_association_exists) if pipeline_entity.nil?
    
    begin
      pipeline_entity.update(admin: admin)
      result = PipelineUser.find_by(user_id: user_id, pipeline_id: pipeline_id)
      return success(:data => result)
    rescue
      return failure(:problem_updating_user)
    end
  end
end