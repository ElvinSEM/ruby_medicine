# class ApplicationController < ActionController::Base
#   before_action :configure_permitted_parameters, if: :devise_controller?
#
#   protected
#
#   def configure_permitted_parameters
#     # Для регистрации
#     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email,:phone, :password, :password_confirmation])
#     # Для обновления данных пользователя
#     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :phone, :password, :password_confirmation, :current_password])
#   end
# end

#
# class ApplicationController < ActionController::Base
#   protect_from_forgery with: :exception
#
#   before_action :configure_permitted_parameters, if: :devise_controller?
#   include Pundit::Authorization
#
#   protected
#
#   def configure_permitted_parameters
#     # Для регистрации
#     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :phone, :password, :password_confirmation])
#     # Для обновления данных пользователя
#     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :phone, :password, :password_confirmation, :current_password])
#   end
#
#   def authenticate_user!
#     if user_signed_in?
#       super
#     else
#       redirect_to new_user_session_path, notice: 'Пожалуйста, войдите в систему, чтобы написать отзыв.'
#     end
#   end
# end


class ApplicationController < ActionController::Base
  include Authorization

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale
  # Обработка исключений Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
  def set_locale
    if params[:locale]
      I18n.locale = params[:locale]
      session[:locale] = I18n.locale
      redirect_back(fallback_location: root_path)
    else
      I18n.locale = session[:locale] || I18n.default_locale
    end
  end

  protected

  def configure_permitted_parameters
    # Для регистрации
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :phone, :password, :password_confirmation])
    # Для обновления данных пользователя
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :phone, :password, :password_confirmation, :current_password])
  end

  private

  # Перенаправление пользователя при попытке выполнения неавторизованного действия
  def user_not_authorized
    flash[:alert] = "У вас нет прав для выполнения этого действия."
    redirect_to(request.referrer || root_path)
  end
end