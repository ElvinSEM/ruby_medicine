# lib/tasks/appointment_reminder.rake

namespace :appointment_reminder do
  desc "Check appointments and send reminders"
  task check_and_send: :environment do
    AppointmentReminderJob.perform_now
  end
end
