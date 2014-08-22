require 'pry-byebug'
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
    # Index to show contacts
    result = RetrieveAllUserInfo.run(params)
    if result.success?
      respond_with result.users.map(&:to_h)
    else
      respond_with(result.error, status: :unprocessable_entity)
    end
  end

  def create
    result = CreateUser.run(params)
    if result.success?
      respond_with(result)
    else
      respond_with(result.error, status: :unprocessable_entity)
    end
  end

end
