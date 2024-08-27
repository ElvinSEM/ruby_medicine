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




# lib/telegram_service.rb
# require 'telegram/bot'
#
# class TelegramService
#   def initialize(user: nil, message: nil)
#     @user = user
#     @message = message
#     @chat_id = user&.telegram_chat_id
#     @bot_token = ENV['TELEGRAM_BOT_API_TOKEN']
#     @bot = Telegram::Bot::Client.new(@bot_token)
#   end
#
#   def self.call(user: nil, message: nil)
#     new(user: user, message: message).perform
#   end
#
#   def perform
#     if @user && @message
#       send_message_to_user
#     else
#       check_and_notify_appointments
#     end
#   end
#
#
#   def check_and_notify_appointments
#     return if @bot_token.blank?
#
#     appointments = Appointment.appointments_in_an_hour
#     appointments.each do |appointment|
#       user = appointment.user
#       msg = "Напоминание: у вас запись на прием с врачом в #{appointment.start_time.strftime('%H:%M')}. Пожалуйста, не забудьте!"
#       binding.pry
#
#       TelegramService.call(user: user, message: msg)
#     end
#   rescue => e
#     Rails.logger.error "Error checking and notifying appointments: #{e.message}"
#   end
#
#   private
#
#   def send_message_to_user
#     return if @message.blank?
#     return if @chat_id.blank? || @bot_token.blank?
#
#     message_chunks.each do |chunk|
#       @bot.api.send_message(chat_id: @chat_id, text: escape(chunk), parse_mode: 'MarkdownV2')
#     end
#   rescue => e
#     Rails.logger.error "Error sending message to user #{@chat_id}: #{e.message}"
#   end
#
#
#
#
#
#   def message_chunks
#     return [] if @message.nil?
#
#     message_limit = 4000
#     (@message.chars.each_slice(message_limit).map(&:join))
#   end
#
#   def escape(text)
#     text.gsub(/([-_*\[\]()~`>#+=|{}.!])/, '\\\\\1')
#   end
# end
