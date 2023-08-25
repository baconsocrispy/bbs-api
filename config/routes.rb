Rails.application.routes.draw do
  resources :products
  use_doorkeeper do 
    controllers tokens: 'cookie_revoke'
  end

  get '/current_user', to: 'users/current_user#current_user'
end
