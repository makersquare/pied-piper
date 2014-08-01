class SessionsController < ApplicationController

  def create
    user = retrieve_oauth_user
    session[:user_id] = user.id
    redirect_to root_path
  end

  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  private
  def retrieve_oauth_user
    User.from_omniauth(env["omniauth.auth"])
  end
end
