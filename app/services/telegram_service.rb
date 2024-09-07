# require 'telegram/bot'
#
# class TelegramService
#   def initialize(user, message)
#     @message   = message
#     @chat_id   = user.telegram_chat_id
#     @bot_token = ENV['TELEGRAM_BOT_API_TOKEN']
#   end
#
#   def self.call(user=nil, message)
#     if user.nil?
#       Rails.logger.error("User not specified for #{self.class}")
#       return
#     end
#
#     new(user, message).report
#   end
#
#   def report
#     unless @message.present?
#       Rails.logger.error 'An empty message has been sent to Telegram!'
#       return
#     end
#
#     if @chat_id.blank? || @bot_token.blank?
#       Rails.logger.error 'Telegram chat ID or bot token not set!'
#       return
#     end
#
#     tg_send
#   end
#
#   private
#
#   def tg_send
#     [@chat_id.to_s.split(',')].flatten.each do |user_id|
#       message_limit = 4000
#       message_count = @message.size / message_limit + 1
#       Telegram::Bot::Client.run(@bot_token) do |bot|
#         message_count.times do
#           splitted_text = @message.chars
#           splitted_text = %w[D e v |] + splitted_text if Rails.env.development?
#           text_part     = splitted_text.shift(message_limit).join
#           bot.api.send_message(chat_id: user_id, text: escape(text_part), parse_mode: 'MarkdownV2')
#         end
#       rescue => e
#         Rails.logger.error e.message
#       end
#     end
#     nil
#   end
#
#   def escape(text)
#     text.gsub(/\[.*?m/, '').gsub(/([-_*\[\]()~`>#+=|{}.!])/, '\\\\\1')
#   end
# end

require 'telegram/bot'

class TelegramService
  def initialize(user, message)
    @message   = message
    @chat_id   = user.telegram_chat_id
    @bot_token = ENV['TELEGRAM_BOT_API_TOKEN']
  end

  def self.call(user:, message:)
    if user.nil?
      Rails.logger.error("User not specified for #{self.name}")
      return
    end

    new(user, message).report
  end

  def report
    unless @message.present?
      Rails.logger.error 'An empty message has been sent to Telegram!'
      return
    end

    if @chat_id.blank? || @bot_token.blank?
      Rails.logger.error 'Telegram chat ID or bot token not set!'
      return
    end

    tg_send
  end

  private

  def tg_send
    [@chat_id.to_s.split(',')].flatten.each do |user_id|
      message_limit = 4000
      message_count = (@message.size.to_f / message_limit).ceil

      Telegram::Bot::Client.run(@bot_token) do |bot|
        message_count.times do
          splitted_text = @message.chars
          splitted_text = %w[D e v |] + splitted_text if Rails.env.development?
          text_part     = splitted_text.shift(message_limit).join
          bot.api.send_message(chat_id: user_id, text: escape(text_part), parse_mode: 'MarkdownV2')
        end
      rescue => e
        Rails.logger.error e.message
      end
    end
    nil
  end

  def escape(text)
    text.gsub(/\[.*?m/, '').gsub(/([-_*\[\]()~`>#+=|{}.!])/, '\\\\\1')
  end
end




#Telegram-бот, который будет автоматически сохранять telegram_user_id на сервере и сможет отправлять уведомления пользователям.
# require 'telegram/bot'
# require 'net/http'
# require 'uri'
#
# class TelegramService
#   def initialize(user, message)
#     @message   = message
#     @chat_id   = user.telegram_chat_id
#     @bot_token = ENV['TELEGRAM_BOT_API_TOKEN']
#   end
#
#   def self.call(user:, message:)
#     if user.blank?
#       Rails.logger.error("User not specified for #{self.name}")
#       return
#     end
#
#     new(user, message).send_message
#   end
#
#   private
#
#   def send_message
#     return if @message.blank?
#
#     if @chat_id.blank? || @bot_token.blank?
#       Rails.logger.error 'Telegram chat ID or bot token not set!'
#       return
#     end
#
#     send_to_telegram
#   end
#
#   def send_to_telegram
#     Telegram::Bot::Client.run(@bot_token) do |bot|
#       bot.api.send_message(chat_id: @chat_id, text: escape_message(@message), parse_mode: 'MarkdownV2')
#     rescue => e
#       Rails.logger.error "Telegram error: #{e.message}"
#     end
#   end
#
#   def escape_message(text)
#     text.gsub(/\[.*?m/, '').gsub(/([-_*\[\]()~`>#+=|{}.!])/, '\\\\\1')
#   end
# end
#
# # Блок для работы с Telegram-ботом
# TOKEN = ENV['TELEGRAM_BOT_API_TOKEN']
#
# Telegram::Bot::Client.run(TOKEN) do |bot|
#   bot.listen do |message|
#     case message.text
#     when '/start'
#       telegram_user_id = message.chat.id
#
#       # Предполагаем, что email пользователя запрашивается на стороне приложения
#       user_email = fetch_user_email(message.from.id) # Важно: Это пример, функция `fetch_user_email` должна быть реализована
#
#       save_user_telegram_id(telegram_user_id, user_email)
#
#       bot.api.send_message(chat_id: telegram_user_id, text: "Ваш аккаунт успешно связан с Telegram!")
#     else
#       bot.api.send_message(chat_id: message.chat.id, text: "Команда не распознана.")
#     end
#   end
# end
#
# def save_user_telegram_id(telegram_user_id, email)
#   uri = URI.parse("https://your-domain.com/telegram/save_user_id")
#   request = Net::HTTP::Post.new(uri)
#   request.set_form_data("telegram_chat_id" => telegram_user_id, "email" => email)
#
#   response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
#     http.request(request)
#   end
#
#   unless response.is_a?(Net::HTTPSuccess)
#     Rails.logger.error("Failed to save telegram_chat_id for email: #{email}")
#   end
# end
#
# def fetch_user_email(user_id)
#   # Предполагаем, что функция получения email реализована на стороне вашего приложения
#   # Например, это может быть обращение к базе данных или API
#   # Пример:
#   User.find_by(telegram_chat_id: user_id)&.email
# end
