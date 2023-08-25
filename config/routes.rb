Rails.application.routes.draw do
  # authentication routes
  use_doorkeeper do 
    controllers tokens: 'cookie_revoke'
  end

  get '/current_user', to: 'users/current_user#current_user'

  # api
  concern :api_base do
    resources :products
    resources :categories
  end
  
  namespace :v1 do
    concerns :api_base
  end
end
