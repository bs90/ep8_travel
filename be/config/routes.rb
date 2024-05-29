Rails.application.routes.draw do
  mount Rswag::Ui::Engine => '/api-docs'
  mount Rswag::Api::Engine => '/api-docs'

  namespace :api, defaults: {format: :json} do
    namespace :v1 do
      post '/signin', to: 'sessions#create'
      post '/signup', to: 'admins#create'
      post '/refresh', to: 'sessions#refresh_token'
    end
  end
end
