class TelegramController < ApplicationController
  skip_before_action :verify_authenticity_token, only: [:save_user_id]

  def save_user_id
    phone = params[:phone].strip
    telegram_chat_id = params[:telegram_chat_id]

    user = User.find_by(phone: phone)

    if user
      if user.telegram_chat_id.nil?
        user.update(telegram_chat_id: telegram_chat_id)
        render plain: "Telegram chat ID успешно сохранен", status: :ok
      else
        render plain: "Telegram chat ID уже существует для данного пользователя", status: :conflict
      end
    else
      render plain: "Пользователь с данным номером телефона не найден", status: :not_found
    end
  end
end
