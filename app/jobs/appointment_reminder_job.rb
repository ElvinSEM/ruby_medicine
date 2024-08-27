class AppointmentReminderJob < ApplicationJob
  queue_as :default

  def perform
    upcoming_appointments = Appointment.appointments_in_an_hour

    upcoming_appointments.each do |appointment|
      user = appointment.user
      doctor = appointment.doctor
      message = "🔔 *Напоминание!* 🔔\n\n🗓️ У вас запись на прием к врачу *#{doctor.name}* \n🕒 *Время:* #{appointment.start_time.strftime('%H:%M')}\n\nПожалуйста, не забудьте! ✅"
      TelegramService.call(user: user, message: message)
    end
  end
end
