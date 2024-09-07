class AppointmentReminderJob < ApplicationJob
  queue_as :default

  def perform
    Rails.logger.info "AppointmentReminderJob started at #{Time.current}"

    # Получение списка записей на прием, которые начнутся через час
    appointments = Appointment.where(start_time: (Time.current.in_time_zone('Moscow') + 1.hour).beginning_of_hour..(Time.current.in_time_zone('Moscow') + 1.hour).end_of_hour)
    Rails.logger.info "Found #{appointments.count} appointments for reminders"

    appointments.each do |appointment|
      if appointment.nil?
        Rails.logger.warn "Encountered a nil appointment, skipping..."
        next
      end

      if appointment.start_time.present? && appointment.doctor.present?
        Rails.logger.info "Sending reminder for appointment #{appointment.id} with doctor #{appointment.doctor.name}"

        user = appointment.user
        doctor = appointment.doctor
        message = "🔔 *Напоминание!* 🔔\n\n🗓️ У вас запись на прием к врачу *#{doctor.name}*\n\n📅 *Дата:* #{appointment.start_time.strftime('%d.%m.%Y')} \n🕒 *Время:* #{appointment.start_time.strftime('%H:%M')}\n\nПожалуйста, не забудьте! ✅"
        TelegramService.call(user: user, message: message)
      else
        Rails.logger.warn "Skipping reminder for appointment #{appointment.id} due to missing data"
      end
    end
  end
end



# def perform
  #   upcoming_appointments = Appointment.appointments_in_an_hour
  #
  #   upcoming_appointments.each do |appointment|
  #     user = appointment.user
  #     doctor = appointment.doctor
  #
  #     # Формирование сообщения для пользователя
  #     message = "🔔 *Напоминание!* 🔔\n\n🗓️ У вас запись на прием к врачу *#{doctor.name}* \n🕒 *Время:* #{appointment.start_time.strftime('%H:%M')}\n\nПожалуйста, не забудьте! ✅"
  #
  #     # Отправка сообщения в Telegram
  #     TelegramService.call(user: user, message: message)
  #
  #     # Сохранение telegram_chat_id
  #     save_telegram_chat_id(user) if user.telegram_chat_id.blank?
  #   end
  # end
  #
  # private
  #
  # def save_telegram_chat_id(user)
  #   # Здесь `fetch_user_email` должен возвращать email пользователя на основе других параметров, если это необходимо
  #   email = user.email
  #
  #   # Параметры для сохранения
  #   telegram_chat_id = user.telegram_chat_id
  #   uri = URI.parse("https://your-domain.com/telegram/save_user_id")
  #   request = Net::HTTP::Post.new(uri)
  #   request.set_form_data("telegram_chat_id" => telegram_chat_id, "email" => email)
  #
  #   response = Net::HTTP.start(uri.hostname, uri.port, use_ssl: uri.scheme == "https") do |http|
  #     http.request(request)
  #   end
  #
  #   unless response.is_a?(Net::HTTPSuccess)
  #     Rails.logger.error("Failed to save telegram_chat_id for email: #{email}")
  #   end
  # end
# end
