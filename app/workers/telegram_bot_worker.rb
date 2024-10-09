# app/workers/telegram_bot_worker.rb
class TelegramBotWorker
  include Sidekiq::Worker

  def perform
    TelegramBotService.start
  end
end
