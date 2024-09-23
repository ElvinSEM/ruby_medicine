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
#
# require 'telegram/bot'
#
# class TelegramService
#   def initialize(user, message)
#     @message   = message
#     @chat_id   = user.telegram_chat_id
#     @bot_token = ENV['TELEGRAM_BOT_API_TOKEN']
#   end
#
#   def self.call(user:, message:)
#     if user.nil?
#       Rails.logger.error("User not specified for #{self.name}")
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
#       message_count = (@message.size.to_f / message_limit).ceil
#
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
#
# #
# require 'telegram/bot'
# app/services/telegram_service.rb
# require 'telegram/bot'
# class TelegramService
#   def initialize(user, message)
#     @message   = message
#     @chat_id   = user.telegram_chat_id
#     @bot_token = ENV['TELEGRAM_BOT_API_TOKEN']
#   end
#
#   def self.send_message(user, message)
#     Rails.logger.info "Отправка сообщения пользователю #{user.username}: #{message.inspect}"
#
#     if user.telegram_chat_id.present?
#       new(user, message).tg_send
#     else
#       Rails.logger.error "Пользователь #{user.username || 'неизвестен'} не имеет Telegram ID. Сообщение не отправлено."
#     end
#   end
#
#   def tg_send
#     dev_prefix = Rails.env.development? ? "[Dev] " : ""
#     final_message = dev_prefix + @message
#
#     Telegram::Bot::Client.run(@bot_token) do |bot|
#       split_message(final_message).each do |text_part|
#         bot.api.send_message(chat_id: @chat_id, text: escape(text_part), parse_mode: 'MarkdownV2')
#       end
#     rescue Telegram::Bot::Exceptions::ResponseError => e
#       log_error("Telegram API Error: #{e.message}")
#     rescue StandardError => e
#       log_error("Unexpected error: #{e.message}")
#     end
#   end
#
#   private
#
#
#   def split_message(message, limit = 4000)
#     message.scan(/.{1,#{limit}}/m)
#   end
#
#   def escape(text)
#     text.gsub(/([-_*\[\]()~`>#+=|{}.!])/, '\\\\\\1')
#   end
#
#   def log_error(error_message)
#     Rails.logger.error error_message
#   end
# end


require 'telegram/bot'

class TelegramService
  def self.call(user:, message:)
    new(user, message).send_message
  end

  def initialize(user, message)
    @chat_id   = user.telegram_chat_id
    @bot_token = ENV['TELEGRAM_BOT_API_TOKEN']
    @message   = format_message(message)
  end

  def send_message
    Telegram::Bot::Client.run(@bot_token) do |bot|
      split_message(@message).each do |text_part|
        bot.api.send_message(chat_id: @chat_id, text: escape(text_part), parse_mode: 'MarkdownV2')
      end
    rescue Telegram::Bot::Exceptions::ResponseError => e
      log_error("Ошибка Telegram API: #{e.message}")
    rescue StandardError => e
      log_error("Неожиданная ошибка: #{e.message}")
    end
  end

  private

  def format_message(message)
    dev_prefix = Rails.env.development? ? "[Dev|] " : ""
    "#{dev_prefix}#{message}"
  end

  def split_message(message, limit = 4000)
    message.scan(/.{1,#{limit}}/m)
  end

  def escape(text)
    text.gsub(/([-_*\[\]()~`>#+=|{}.!])/, '\\\\\\1')
  end

  def log_error(error_message)
    Rails.logger.error error_message
  end
end
