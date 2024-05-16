# spec/controllers/users_controller_spec.rb
require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'GET #show' do
    it 'assigns the requested user to @user' do
      user = create(:user)
      get :show, params: { id: user }
      expect(assigns(:user)).to eq(user)
    end

    it 'renders the :show template' do
      user = create(:user)
      get :show, params: { id: user }
      expect(response).to render_template :show
    end
  end

  # Добавьте другие тесты для действий edit, update и т.д.
end