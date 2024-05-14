Rails.application.routes.draw do

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post '/signin', to: 'sessions#create'
      post '/signup', to: 'admins#create'
      post '/refresh', to: 'sessions#refresh_token'
    end
  end
end
