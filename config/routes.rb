# require 'sidekiq/web'
# Rails.application.routes.draw do
#   mount Sidekiq::Web => '/sidekiq'
#   # devise_for :admin_users, ActiveAdmin::Devise.config
#   # Маршруты Devise для обычных пользователей
#   # devise_for :users
#   devise_for :users, controllers: {
#     omniauth_callbacks: 'users/omniauth_callbacks'
#   }
#   scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
#
#   root 'home#index'
#   resources :appointments
#   # resources :patients
#   resources :doctors do
#     resources :reviews, only: [:index, :new, :create, :destroy]
#   end
#   get '/set_locale/:locale', to: 'application#set_locale', as: :set_locale
#   get 'search', to: 'pages#search', as: 'search'
#
#   resources :services
#   resources :reviews, only: [:index, :show, :new, :create, :destroy] do
#     collection do
#       get 'show_all'
#     end
#    end
#   end
# end

#
# require 'sidekiq/web'
#
# Rails.application.routes.draw do
#   mount Sidekiq::Web => '/sidekiq'
#
#   devise_for :users, controllers: {
#     omniauth_callbacks: 'users/omniauth_callbacks'
#   }
#
#   # Добавляем локаль как часть маршрутов
#   scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
#
#     root 'home#index'
#     devise_for :users
#     resources :users, only: [:show]
#     post 'telegram/save_user_id', to: 'telegram#save_user_id'
#     resources :appointments
#
#     resources :doctors do
#       resources :reviews, only: [:index, :new, :create, :destroy]
#     end
#
#     # Маршрут для установки локали
#     get '/set_locale/:locale', to: 'application#set_locale', as: :set_locale, defaults: { format: :html }
#
#     # Другие маршруты
#     get 'search', to: 'pages#search', as: 'search'
#
#     resources :services
#     resources :reviews, only: [:index, :show, :new, :create, :destroy] do
#       collection do
#         get 'show_all'
#       end
#     end
#   end
# end

require 'sidekiq/web'
Rails.application.routes.draw do
  mount Sidekiq::Web => '/sidekiq'

  devise_for :users, controllers: {
    omniauth_callbacks: 'users/omniauth_callbacks'
  }

  scope "(:locale)", locale: /#{I18n.available_locales.join("|")}/ do
    root 'home#index'
    resources :users, only: [:show]
    post 'telegram/save_user_id', to: 'telegram#save_user_id'
    resources :appointments
    resources :services, only: [:index, :show]

    resources :doctors do
      resources :reviews, only: [:index, :new, :create, :destroy]
    end

    get '/set_locale/:locale', to: 'application#set_locale', as: :set_locale, defaults: { format: :html }
    get 'search', to: 'pages#search', as: 'search'
    resources :reviews, only: [:index, :show, :new, :create, :destroy] do
      collection do
        get 'show_all'
      end
    end
  end
end
