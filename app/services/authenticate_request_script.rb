
class AuthenticateRequestScript < TransactionScript
  def run(params)
    # check that the token returns a user
    return failure(error: :security_token_not_present) if params[:token] == nil
    user = User.find_by(oauth_token: params[:token])
    # oauth token does not exist for a user
    return failure(error: :token_does_not_belong_to_a_user_i_apologise_immenseley_for_this_error_and_hope_that_it_will_not_arrise_again_please_call_the_toll_free_number_in_order_to_make_a_fix) if user == nil
    # Token is expired
    return failure(error: :token_is_expired) if user[:oauth_expires_at].to_time < Time.now
    return success(data: user)
  end
end
