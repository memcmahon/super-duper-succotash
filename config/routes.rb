Rails.application.routes.draw do
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"

  # API Artists endpoints
  get "/api/v1/artists", to: 'api/v1/artists#index'
  post "/api/v1/artists", to: 'api/v1/artists#create'
  get "/api/v1/artists/:id", to: 'api/v1/artists#show'
  patch "/api/v1/artists/:id", to: 'api/v1/artists#update'
  put "/api/v1/artists/:id", to: 'api/v1/artists#update'
  delete "/api/v1/artists/:id", to: 'api/v1/artists#destroy'

  # API Nested Songs under Artists
  get "/api/v1/artists/:artist_id/songs", to: 'api/v1/songs#index'

  # API Songs endpoints
  get "/api/v1/songs", to: 'api/v1/songs#index'
  post "/api/v1/songs", to: 'api/v1/songs#create'
  get "/api/v1/songs/:id", to: 'api/v1/songs#show'
  patch "/api/v1/songs/:id", to: 'api/v1/songs#update'
  put "/api/v1/songs/:id", to: 'api/v1/songs#update'
  delete "/api/v1/songs/:id", to: 'api/v1/songs#destroy'
end
