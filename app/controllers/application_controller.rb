class ApplicationController < ActionController::Base
  include Authorization
  include BreadcrumbsOnRails::ActionController

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
