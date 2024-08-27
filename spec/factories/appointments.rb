#spec/factories/appointments.rb
FactoryBot.define do
  factory :appointment do
    doctor
    user
    appointment_date { Time.now }
  end
end