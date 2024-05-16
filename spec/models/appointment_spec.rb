require 'rails_helper'

# spec/models/appointment_spec.rb
require 'rails_helper'

RSpec.describe Appointment, type: :model do
  it { should belong_to(:user) }
  it { should belong_to(:doctor) }

  it "is valid with valid attributes" do
    doctor = create(:doctor)
    patient = create(:patient)
    appointment = build(:appointment, doctor: doctor, patient: patient)
    expect(appointment).to be_valid
  end

  it "is not valid without a doctor" do
    appointment = build(:appointment, doctor: nil)
    expect(appointment).not_to be_valid
  end

  it "is not valid without a patient" do
    appointment = build(:appointment, patient: nil)
    expect(appointment).not_to be_valid
  end

  it "is not valid without an appointment_date" do
    appointment = build(:appointment, appointment_date: nil)
    expect(appointment).not_to be_valid
  end

  it "is not valid without a status" do
    appointment = build(:appointment, status: nil)
    expect(appointment).not_to be_valid
  end
end
