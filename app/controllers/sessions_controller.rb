class SessionsController < ApplicationController
  #brings in user object from Oauth call and assigns id to session id on login
  def create
    user = retrieve_oauth_user
    session[:user_id] = user.id
    redirect_to root_path
  end

  #sets the the user session to nil on logout
  def destroy
    session[:user_id] = nil
    redirect_to root_path
  end

  #calls the user model method which returns a google-oauth user object persists it in db
  private
  def retrieve_oauth_user
    User.from_omniauth(env["omniauth.auth"])
  end
end
