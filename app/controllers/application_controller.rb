require 'pry-byebug'
class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  after_filter :set_csrf_cookie_for_ng
  helper_method :current_user
  before_action :validate_token, except: [:login]

  def current_user
    @current_user ||= User.find(session[:user_id]) if session[:user_id]
  end

  def set_csrf_cookie_for_ng
    cookies['XSRF-TOKEN'] = form_authenticity_token if protect_against_forgery?
  end

  protected
  def verified_request?
    super || form_authenticity_token == request.headers['X-XSRF-TOKEN']
  end

  def validate_token
    result = AuthenticateRequestScript.run({token: cookies.signed[:atkn]})
    unless result.success?
      flash[:error] = result.error
      redirect_to '/login'
    end

  end

end
