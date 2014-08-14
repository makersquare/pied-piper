class RetrieveUserPipelines < TransactionScript
  def run(user_id)
    begin
      pu = PipelineUser.where(user_id: user_id)
      pipelines_output = []
      pu.each { |pipeline_user_entity|
        pipelines_output << pipeline_user_entity.pipeline
      }
      return success(data: pipelines_output)
    rescue
      return failure(:problem_retrieving_users_pipelines)
    end
  end
end