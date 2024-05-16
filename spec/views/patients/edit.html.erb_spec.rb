require 'rails_helper'

RSpec.describe "patients/edit", type: :view do
  before(:each) do
    @patient = assign(:patient, Patient.create!(
      name: "MyString",
      phone: "MyString",
      email: "test@example.com"
    ))
  end


  it "renders the edit patient form" do
    render

    assert_select "form[action=?][method=?]", patient_path(@patient), "post" do

      assert_select "input[name=?]", "patient[name]"

      assert_select "input[name=?]", "patient[phone]"

      assert_select "input[name=?]", "patient[email]"
    end
  end
end
