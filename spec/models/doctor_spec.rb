# spec/models/doctor_spec.rb
require 'rails_helper'

RSpec.describe Doctor, type: :model do
  it { should have_many(:appointments) }
  it { should have_many(:users).through(:appointments) }
  it "is valid with valid attributes" do
    doctor = build(:doctor)
    expect(doctor).to be_valid
  end

  it "is not valid without a name" do
    doctor = build(:doctor, name: nil)
    expect(doctor).not_to be_valid
  end

  it "is not valid without a specialty" do
    doctor = build(:doctor, specialty: nil)
    expect(doctor).not_to be_valid
  end

  describe "associations" do
    it "has many appointments" do
      expect(Doctor.new).to respond_to(:appointments)
    end

    it "has many patients through appointments" do
      should have_many(:patients).through(:appointments)
    end
  end
end