class UsersController < ApplicationController
  respond_to :json
  # # POST /users
  # # POST /users.json

  # def create
  #   @user = User.new(params[:user])

  #   respond_to do |format|
  #     if @user.save
  #       # UserMailer sends a welcome email after save
  #       UserMailer.welcome_email(@user).deliver

  #       format.html { redirect_to(@user, notice: 'User was successfully created.')}
  #       format.json { render json: @user, status: :created, location: @user }
  #     else
  #       format.html { render action: 'new' }
  #       format.json { render json: @user.errors, status: :unprocessable_entity }
  #     end
  #   end
  # end

  def index
    user_entities = User.all
    sanitized_user_json = []
    user_entities.each { |u|
      sanitized_user_json << sanitize_user_data(u.as_json)
    }
    respond_with sanitized_user_json
  end

  private

  def sanitize_user_data(user_json)
    user_json.delete "oauth_token"
    user_json.delete "provider"
    user_json.delete "created_at"
    user_json.delete "updated_at"
    user_json.delete "oauth_expires_at"
    user_json.delete "webhook_id"
    user_json.delete "uid"

    return user_json
  end

end
