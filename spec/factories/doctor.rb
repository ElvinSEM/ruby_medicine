# spec/factories/doctors.rb
FactoryBot.define do
  factory :doctor do
    name { "Dr. Strange" }
    specialty { "Ophthalmology" }
  end
end
