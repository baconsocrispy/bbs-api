class Users::CurrentUserController < ApplicationController
  include AuthenticateUser
  before_action :authenticate_request!

  # get /admin/current_user
  def index
    render json: UserSerializer.new(current_user).serializable_hash[:data][:attributes]
  end
end