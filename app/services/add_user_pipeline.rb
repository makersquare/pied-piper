class AddUserPipeline < TransactionScript
  def run(params)
    #Not bothering to check for data integrity here, we should control that
    # on the frontend
    user_id = params[:user_id]
    pipeline_id = params[:id]
    params[:pipeline_admin] == false ? admin = 'false' : admin = 'true'
    return failure(:user_already_in_pipeline) unless PipelineUser.find_by(user_id: user_id, pipeline_id: pipeline_id).nil?
    
    begin
      result = PipelineUser.create(user_id: user_id, pipeline_id: pipeline_id, admin: admin)
      EmailSetting.create(pipeline_user_id: result.id)
      return success(:data => result)
    rescue
      return failure(:problem_adding_user)
    end
  end
end