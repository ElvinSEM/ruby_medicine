require 'rails_helper'

RSpec.describe "appointments/show", type: :view do
  before(:each) do
    doctor = FactoryBot.create(:doctor)
    patient = FactoryBot.create(:patient)
    @appointment = assign(:appointment, FactoryBot.create(:appointment, doctor: doctor, patient: patient))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Status/)
    expect(rendered).to match(//)
    expect(rendered).to match(//)
  end
end
