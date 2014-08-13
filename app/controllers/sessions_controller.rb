
class SessionsController < ApplicationController
  #brings in user object from Oauth call and assigns id to session id on login
  skip_before_action :validate_token, :only => [:create, :destroy]

  def create
    result = UserPreauthScript.run(auth: env["omniauth.auth"])

    if result.success?
      user = result.user

      session[:user_id] = user.id
      # atkn is the auth token
      cookies.signed[:atkn] = {
        value: user[:oauth_token],
        expires: user[:oauth_expires_at].to_time
      }

      redirect_to root_path
    else
      flash[:error] = result.error
      redirect_to "/login"
    end

  end

  #sets the the user session to nil on logout
  def destroy
    session[:user_id] = nil
    cookies.delete(:atkn)
    redirect_to '/login'
  end
end
