# frozen_string_literal: true

# Controller for managing users in the application.
# Provides actions like creating, updating, showing, and deleting users.
class UsersController < ApplicationController
  before_action :set_user, only: %i[show edit update destroy]

  # GET /users
  def index
    @users = User.all
  end

  # GET /users/1
  def show
    @user = current_user
    # Если у пользователя нет привязанного telegram_chat_id, предлагается привязать
    return unless @user.telegram_chat_id.blank?

    @telegram_bot_link = 'https://t.me/CLINIC777_bot'
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit; end

  # POST /users
  def create
    @user = User.new(user_params)
    if @user.save
      UserMailer.welcome_email(@user).deliver_now
      @telegram_bot_link = 'https://t.me/CLINIC777_bot'
      redirect_to @user, notice: 'Пользователь успешно создан.'
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /users/1
  def update
    if @user.update(user_params)
      redirect_to @user, notice: 'User был успешно обновлен.', status: :see_other
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /users/1
  def destroy
    @user.destroy
    redirect_to root_path, notice: 'User был успешно удален.', status: :see_other
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def user_params
    params.require(:user).permit(:username, :email, :password, :password_confirmation)
  end
end
