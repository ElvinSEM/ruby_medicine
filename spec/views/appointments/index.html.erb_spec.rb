require 'rails_helper'

# spec/views/appointments/index.html.erb_spec.rb
# require 'rails_helper'
#
# RSpec.describe "appointments/index", type: :view do
#   before(:each) do
#     assign(:appointments, [
#       FactoryBot.create(:appointment),
#       FactoryBot.create(:appointment)
#     ])
#   end
#
#   it "renders a list of appointments" do
#     render
#     assert_select "tr>td", count: @appointments.count * 5
#   end
# end

# spec/views/appointments/index.html.erb_spec.rb
require 'rails_helper'

RSpec.describe "appointments/index", type: :view do
  before(:each) do
    # Создаем валидные объекты doctor и patient
    doctor = FactoryBot.create(:doctor)
    patient = FactoryBot.create(:patient)

    # Используем созданные объекты для создания appointments
    assign(:appointments, [
      FactoryBot.create(:appointment, doctor: doctor, patient: patient),
      FactoryBot.create(:appointment, doctor: doctor, patient: patient)
    ])
  end

  it "renders a list of appointments" do
    render
    # Убедитесь, что используете правильный селектор для элементов, которые рендерятся в представлении
    expect(rendered).to match(/Dr. Strange/)
    expect(rendered).to match(/John Doe/)
    # Добавьте дополнительные проверки для других атрибутов, если необходимо
  end
end