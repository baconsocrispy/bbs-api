class Users::CurrentUserController < ActionController::API
  before_action :doorkeeper_authorize!

  def current_user
    p 'Token'
    p doorkeeper_token
    return render json: { 'test': 'test'}
  end
end