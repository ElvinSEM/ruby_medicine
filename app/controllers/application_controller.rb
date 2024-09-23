# # class ApplicationController < ActionController::Base
# #   before_action :configure_permitted_parameters, if: :devise_controller?
# #
# #   protected
# #
# #   def configure_permitted_parameters
# #     # Для регистрации
# #     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email,:phone, :password, :password_confirmation])
# #     # Для обновления данных пользователя
# #     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :phone, :password, :password_confirmation, :current_password])
# #   end
# # end
#
# #
# # class ApplicationController < ActionController::Base
# #   protect_from_forgery with: :exception
# #
# #   before_action :configure_permitted_parameters, if: :devise_controller?
# #   include Pundit::Authorization
# #
# #   protected
# #
# #   def configure_permitted_parameters
# #     # Для регистрации
# #     devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :email, :phone, :password, :password_confirmation])
# #     # Для обновления данных пользователя
# #     devise_parameter_sanitizer.permit(:account_update, keys: [:username, :email, :phone, :password, :password_confirmation, :current_password])
# #   end
# #
# #   def authenticate_user!
# #     if user_signed_in?
# #       super
# #     else
# #       redirect_to new_user_session_path, notice: 'Пожалуйста, войдите в систему, чтобы написать отзыв.'
# #     end
# #   end
# # end
#
# class ApplicationController < ActionController::Base
#   include Authorization
#
#   protect_from_forgery with: :exception
#
#   before_action :configure_permitted_parameters, if: :devise_controller?
#   before_action :set_locale
#
#   # Обработка исключений Pundit
#   rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized
#
#   around_action :switch_locale
#   # def set_locale
#   #   # Если локаль передана в параметрах и отличается от текущей
#   #   if params[:locale] && params[:locale] != I18n.locale.to_s
#   #     if I18n.available_locales.map(&:to_s).include?(params[:locale])
#   #       I18n.locale = params[:locale]
#   #       session[:locale] = I18n.locale
#   #       # Перенаправляем пользователя на ту же страницу только при изменении локали
#   #       redirect_back(fallback_location: root_path) and return
#   #     else
#   #       flash.now[:alert] = "Locale #{params[:locale]} is not available."
#   #       I18n.locale = I18n.default_locale
#   #     end
#   #   else
#   #     # Устанавливаем локаль из сессии или по умолчанию, если параметры отсутствуют
#   #     I18n.locale = session[:locale] || I18n.default_locale
#   #   end
#   # end
#
#   def set_locale
#     # Проверяем, если локаль отличается от текущей, выполняем редирект
#     if params[:locale] && params[:locale] != I18n.locale.to_s
#       if I18n.available_locales.map(&:to_s).include?(params[:locale])
#         I18n.locale = params[:locale]
#         session[:locale] = I18n.locale
#         # Перенаправляем пользователя только если локаль изменилась
#         redirect_to request.referrer || root_path(locale: I18n.locale) and return
#       else
#         flash.now[:alert] = "Locale #{params[:locale]} is not available."
#         I18n.locale = I18n.default_locale
#       end
#     else
#       # Устанавливаем локаль из сессии, если локаль не передана или она уже текущая
#       I18n.locale = session[:locale] || I18n.default_locale
#     end
#   end
#
#
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
#   private
#
#   def switch_locale(&action)
#     locale = params[:locale] || I18n.default_locale
#     I18n.with_locale locale, &action
#   end
#   def locale_from_url
#     locale = params[:locale]
#     return locale if i18n.available_locales.map(&:to_s).include?(locale)
#   end
#   def default_url_options
#     { locale: I18n.locale }
#   end
#
#   # Перенаправление пользователя при попытке выполнения неавторизованного действия
#   def user_not_authorized
#     flash[:alert] = "У вас нет прав для выполнения этого действия."
#     redirect_to(request.referrer || root_path)
#   end
# end


class ApplicationController < ActionController::Base
  include Authorization

  protect_from_forgery with: :exception

  before_action :configure_permitted_parameters, if: :devise_controller?
  before_action :set_locale

  # Обработка исключений Pundit
  rescue_from Pundit::NotAuthorizedError, with: :user_not_authorized

  around_action :switch_locale

  # Перенаправление в личный кабинет после входа
  def after_sign_in_path_for(resource)
    user_path(resource) # Перенаправляем в личный кабинет пользователя
  end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: %i[username email phone password password_confirmation])
    devise_parameter_sanitizer.permit(:account_update, keys: %i[username email phone password password_confirmation current_password])
  end

  private

  def set_locale
    I18n.locale = if params[:locale].in?(I18n.available_locales.map(&:to_s))
                    params[:locale]
                  else
                    session[:locale] || I18n.default_locale
                  end
    session[:locale] = I18n.locale if params[:locale]
  end

  def switch_locale(&action)
    I18n.with_locale(locale_param, &action)
  end

  def locale_param
    params[:locale] || I18n.default_locale
  end

  def default_url_options
    { locale: I18n.locale }
  end

  def user_not_authorized
    flash[:alert] = "У вас нет прав для выполнения этого действия."
    redirect_to(request.referrer || root_path)
  end
end
