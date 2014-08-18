
class AuthenticateRequestScript < TransactionScript
  def run(params)
    # Check that token is present
    return failure(error: :security_token_not_present) if params[:token] == nil
    # check that the token returns a user
    # TODO: do we want to check that the token returns a user and that the user = @current_user
    user = User.find_by(oauth_token: params.fetch(:token))
    # oauth token does not exist for a user
    return failure(error: :no_token_for_user) if user == nil
    # Token is expired
    return failure(error: :token_is_expired) if user[:oauth_expires_at].to_time < Time.now
    return success(data: user)
  end
end
