Rails.application.routes.draw do
  # authentication routes
  use_doorkeeper do 
    controllers tokens: 'cookie_revoke'
  end

  get '/current_user', to: 'users/current_user#current_user'

  scope :users do
    post :signup, to: 'users/signup#create'
  end

  # api
  concern :api_base do
    resources :categories
    resources :contact, only: %i[ create ]
    resources :groups
    resources :hero_contents
    resources :products
    resources :summaries
  end
  
  namespace :v1 do
    concerns :api_base
  end
end
