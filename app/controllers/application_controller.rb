class ApplicationController < ActionController::Base
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    # Для регистрации
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email,:phone, :password, :password_confirmation])
    # Для обновления данных пользователя
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :phone, :password, :password_confirmation, :current_password])
  end
end
