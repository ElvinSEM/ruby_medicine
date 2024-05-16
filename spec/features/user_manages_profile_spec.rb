require 'rails_helper'


RSpec.feature 'User manages profile', type: :feature do
  scenario 'User views their profile' do
    user = create(:user)
    sign_in user
    visit user_path(user)
    expect(page).to have_content(user.username) # Используем `username` вместо `name`
  end

  scenario 'User updates their profile' do
    user = create(:user)
    sign_in user
    visit edit_user_registration_path
    fill_in 'user_username', with: 'New Name' # Используйте идентификатор поля 'user_username'
    click_button 'Update'
    expect(page).to have_content('Your account has been updated successfully.')
    expect(page).to have_content('New Name')
  end
end