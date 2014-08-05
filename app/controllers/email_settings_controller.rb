class EmailSettingsController < ApplicationController
  respond_to :json, :html

  def index
    u = User.find(params[:user_id])
    respond_with(u.email_settings)
  end

  def update
    # update_email_settings =
  end


end

