require 'rails_helper'

# spec/views/appointments/edit.html.erb_spec.rb
RSpec.describe "appointments/edit", type: :view do
  before(:each) do
    @doctor = FactoryBot.create(:doctor)
    @patient = FactoryBot.create(:patient)
    @appointment = assign(:appointment, Appointment.create!(
      doctor: @doctor,
      patient: @patient,
      appointment_date: DateTime.now,
      status: "MyString"
    ))
  end

  it "renders the edit appointment form" do
    render

    assert_select "form[action=?][method=?]", appointment_path(@appointment), "post" do
      assert_select "input[name=?]", "appointment[status]"
      # Проверьте другие поля формы
    end
  end
end