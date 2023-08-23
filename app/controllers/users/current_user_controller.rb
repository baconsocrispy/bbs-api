class Users::CurrentUserController < ActionController::API
  before_action :doorkeeper_authorize!

  def current_user
    user = User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
    render json: UserSerializer.new(user).serializable_hash[:data][:attributes]
  end
end