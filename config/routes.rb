Rails.application.routes.draw do
  use_doorkeeper do 
    controllers tokens: 'cookie_revoke'
  end

  get '/current_user', to: 'users/current_user#current_user'
end
