require 'rails_helper'
RSpec.describe Users::OmniauthCallbacksController, type: :controller do
  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
    request.env['omniauth.auth'] = OmniAuth.config.mock_auth[:google_oauth2]
  end

  describe 'GET #google_oauth2' do
    it 'создает нового пользователя при первом логине' do

      expect { get :google_oauth2 }.to change(User, :count).by(1)
    end

    it 'не создает нового пользователя при повторном логине' do
      get :google_oauth2
      expect { get :google_oauth2 }.not_to change(User, :count)
    end

    it 'направляет пользователя на главную страницу после успешного логина' do
      get :google_oauth2
      expect(response).to redirect_to(root_path)
    end
  end
end


