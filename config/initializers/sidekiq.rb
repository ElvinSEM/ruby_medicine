require 'sidekiq'
require 'sidekiq/cron'

Sidekiq.configure_server do |config|
  config.redis = { url: 'redis://localhost:6379/1' }
  Dir[Rails.root.join('app/workers/*.rb')].each { |file| require file }

  # Load the cron jobs
  Sidekiq::Cron::Job.load_from_hash!({
                                       'appointment_reminder' => {
                                         'class' => 'AppointmentReminderJob',
                                         'cron'  => '*/30 * * * *', # Every 30 minutes
                                         'queue' => 'default'
                                       }
                                     })
end

Sidekiq.configure_client do |config|
  config.redis = { url: 'redis://localhost:6379/1' }
end
