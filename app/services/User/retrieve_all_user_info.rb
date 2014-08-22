# Retrieves all users from databases, but also
# injects data about which pipelines the user is
# a part of.

class RetrieveAllUserInfo < TransactionScript
  def run(params)
    # Gather all user information, but also send data about the pipelines
    users = User.all.map do |user|
      # Convert to OpenStruct for ease of use
      user_struct = OpenStruct.new(user.serializable_hash)
      # Add pipeline data to array
      add_pipeline_info_to_user(user, user_struct)
      # Remove sensative information
      sanitize_user_data(user_struct)
      user_struct
    end

    return success(users: users)
  end

  # Retrieves information about which pipelines the contact is in.
  def add_pipeline_info_to_user(user, user_struct)
    pipelines = user.pipelines
    user_struct.pipelines = pipelines.to_a.map(&:serializable_hash)
  end

  private

  def sanitize_user_data(user_struct)
    user_struct.delete_field "oauth_token"
    user_struct.delete_field "provider"
    user_struct.delete_field "created_at"
    user_struct.delete_field "updated_at"
    user_struct.delete_field "oauth_expires_at"
    user_struct.delete_field "webhook_id"
    user_struct.delete_field "uid"

    return user_struct
  end

end
