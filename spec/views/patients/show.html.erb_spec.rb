require 'rails_helper'

RSpec.describe "patients/show", type: :view do
  before(:each) do
    assign(:patient, Patient.create!(
      name: "Name",
      phone: "Phone",
      email: "test1@example.com"
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(/Name/)
    expect(rendered).to match(/Phone/)
    expect(rendered).to match(/Email/)
  end
end
