require 'sidekiq/web'

Rails.application.routes.draw do
  get '/movies/:title', to: 'movies#show'
  resources :movies
  mount Sidekiq::Web => '/sidekiq'

  # For details on the DSL available within this file, see https://guides.rubyonrails.org/routing.html
end
