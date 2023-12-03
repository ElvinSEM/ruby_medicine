Rails.application.routes.draw do
  get 'home/index'
  devise_for :users
  root to: 'home#index'
  resources :doctors
  resources :nurses
  resources :patients
end
