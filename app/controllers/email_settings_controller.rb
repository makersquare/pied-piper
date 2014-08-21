class EmailSettingsController < ApplicationController
  respond_to :json

  def index
    respond_with(GetEmailSettings.run(params))
  end

  def update
    email_settings = EmailSetting.find(params[:id])
    email_settings.update!(email_setting_params)
    respond_with email_settings
  end

  private
  def email_setting_params
    params.permit(:setting)
  end
end