class TelegramBotWorker
  include Sidekiq::Worker

  def perform(user_id, message)
    user = User.find_by(id: user_id)
    return unless user && user.telegram_chat_id.present?

    # Отправляем сообщение пользователю через Telegram
    TelegramService.call(user: user, message: message)
  end
end
