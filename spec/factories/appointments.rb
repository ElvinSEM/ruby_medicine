#spec/factories/appointments.rb
FactoryBot.define do
  factory :appointment do
    doctor
    patient
    user
    appointment_date { Time.now }
    status { "запланирован" }
  end
end