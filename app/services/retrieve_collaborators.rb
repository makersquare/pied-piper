class RetrieveCollaborators < TransactionScript
  def run(pipeline_id)
    output_array = []
    pu = PipelineUser.where(pipeline_id: pipeline_id)
    pu.each { |pu_entity|
      user_entity = pu_entity.user
      pu_json = pu_entity.as_json
      pu_json["user_data"] = sanitize_user_data(user_entity.as_json)
      output_array << pu_json
    }
    binding.pry
    return success(data: output_array)
  end
end

# result = RetrieveCollaborators.run(1)
# Need to not retur all the user row info here. Also should try to make one user db call and then put together