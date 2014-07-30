class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  # TODO:
  # This is made for the purpose of stubbing users
  # We'll build a real auth system later
  # When testing, stub current_user
  def current_user
    # User.new(name: "Shehzan", email: "shehzan@makersquare.com", admin: true)
  end
end
