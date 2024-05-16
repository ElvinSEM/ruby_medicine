require 'rails_helper'


RSpec.describe "patients/index", type: :view do
  before(:each) do
    assign(:patients, [
      FactoryBot.create(:patient, phone: "1234567890", email: "test1@example.com"),
      FactoryBot.create(:patient, phone: "0987654321", email: "test2@example.com")
    ])
  end

  it "renders a list of patients" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Name".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Phone".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
  end
end
