require 'rails_helper'

RSpec.describe "users/index", type: :view do
  before(:each) do
    assign(:users, [
      User.create!(
        username: "Username",
        email: "Email",
        password_: "Password ",
        digest: "Digest"
      ),
      User.create!(
        username: "Username",
        email: "Email",
        password_: "Password ",
        digest: "Digest"
      )
    ])
  end

  it "renders a list of users" do
    render
    cell_selector = Rails::VERSION::STRING >= '7' ? 'div>p' : 'tr>td'
    assert_select cell_selector, text: Regexp.new("Username".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Email".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Password ".to_s), count: 2
    assert_select cell_selector, text: Regexp.new("Digest".to_s), count: 2
  end
end
