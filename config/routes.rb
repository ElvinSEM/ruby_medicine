Rails.application.routes.draw do
  devise_for :users
  # resources :users

  root 'home#index'
  resources :appointments
  # resources :patients
  resources :doctors do
    resources :reviews, only: [:index, :new, :create, :destroy]
  end

  resources :services
  resources :reviews

end

# resources :main, only: [:index, :show]
# # Ресурсы для пациентов
# resources :patients do
#   resources :appointments # вложенные ресурсы для записей на прием
# end
#
# # Ресурсы для врачей
# resources :doctors do
#   resources :appointments # вложенные ресурсы для записей на прием
# end
#
# # Ресурсы для записей на прием
# resources :appointments
#
# # Можно добавить дополнительные маршруты для специфических страниц или действий
# # get 'special_page', to: 'controller#action'
#
