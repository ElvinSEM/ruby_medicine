Rails.application.routes.draw do
  # devise_for :admin_users, ActiveAdmin::Devise.config
  # Маршруты Devise для обычных пользователей
  devise_for :users

  root 'home#index'
  resources :appointments
  # resources :patients
  resources :doctors do
    resources :reviews, only: [:index, :new, :create, :destroy]
  end

  resources :services
  resources :reviews
  # Если вам нужно добавить маршруты для административной панели, используйте пространство имен:
  # namespace :admin do
  #   resources :users
  #   # Добавьте другие ресурсы или маршруты, специфичные для вашей административной панели
  # end

end

