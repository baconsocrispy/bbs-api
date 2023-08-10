Rails.application.routes.draw do
  devise_for :users, path: 'admin', path_names: {
    sign_in: 'signin',
    sign_out: 'signout',
    registration: 'signup'
  }, 
  controllers: {
    sessions: 'users/sessions',
    registrations: 'users/registrations'
  }

  get '/current_user', to: 'users/current_user#index'
end
