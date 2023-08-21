Rails.application.routes.draw do
  use_doorkeeper
  # devise_for :users, path: 'admin', path_names: {
  #   sign_in: 'signin',
  #   sign_out: 'signout',
  #   registration: 'signup'
  # }, 
  # controllers: {
  #   sessions: 'users/sessions',
  #   registrations: 'users/registrations'
  # }
end
