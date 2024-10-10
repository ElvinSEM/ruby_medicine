# app/workers/telegram_bot_worker.rb
class TelegramBotWorker
  include Sidekiq::Worker

  def perform
    TelegramBotService.start # Или ваш код для выполнения задачи
  end
end
