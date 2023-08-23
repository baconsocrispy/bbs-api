Rails.application.routes.draw do
  use_doorkeeper

  get '/current_user', to: 'users/current_user#current_user'
end
