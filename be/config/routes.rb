Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post '/signin', to: 'tokens#create'
      post '/signup', to: 'users#create'
      post '/refresh', to: 'tokens#refresh_token'
    end
  end
  # Define your application routes per the DSL in https://guides.rubyonrails.org/routing.html

  # Reveal health status on /up that returns 200 if the app boots with no exceptions, otherwise 500.
  # Can be used by load balancers and uptime monitors to verify that the app is live.
  get "up" => "rails/health#show", as: :rails_health_check

  # Defines the root path route ("/")
  # root "posts#index"
end
