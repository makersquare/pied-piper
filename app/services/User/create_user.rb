require 'ostruct'

class CreateUser < TransactionScript
  def run(params)
    params = OpenStruct.new(params) if params.is_a?(Hash)
    return failure 'User already in database' if user_already_exists?(params)

    result = User.create({
      name: params.name,
      email: params.email,
      provider: params.provider,
      oauth_token: params.oauth_token,
      oauth_expires_at: params.oauth_expires_at,
      webhook_id: params.webhook_id
      })

    if result
      UserMailer.registration_email(result).deliver
    end

    return success(user: result)
  end

  def user_already_exists?(params)
    email = User.find_by(email: params.email)
    name = User.find_by(name: params.name)
    if name.nil? && email.nil?
      return false
    end
    return true
  end
end
