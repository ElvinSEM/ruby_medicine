require 'rails_helper'

RSpec.describe Patient, type: :model do
  it "is valid with valid attributes" do
    patient = build(:patient)
    expect(patient).to be_valid
  end

  it "is not valid without a name" do
    patient = build(:patient, name: nil)
    expect(patient).not_to be_valid
  end

  it "is not valid without a phone " do
    patient = build(:patient, phone: nil)
    expect(patient).not_to be_valid
  end

  it "is not valid without a email " do
    patient = build(:patient, email: nil)
    expect(patient).not_to be_valid
  end

  describe "associations" do
    it "has many appointments" do
      expect(Patient.new).to respond_to(:appointments)
    end

    it "has many doctors through appointments" do
      should have_many(:doctors).through(:appointments)
    end
  end
  # pending "add some examples to (or delete) #{__FILE__}"
end
