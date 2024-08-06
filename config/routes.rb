Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # Маршруты Devise для обычных пользователей
  # devise_for :users
  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  root 'home#index'
  resources :appointments
  # resources :patients
  resources :doctors do
    resources :reviews, only: [:index, :new, :create, :destroy]
  end
  get '/set_locale/:locale', to: 'application#set_locale', as: :set_locale
  get 'search', to: 'pages#search', as: 'search'

  resources :services
  resources :reviews, only: [:index, :show, :new, :create, :destroy] do
    collection do
      get 'show_all'
    end
  end
end

