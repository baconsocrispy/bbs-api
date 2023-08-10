class CurrentUserController < ApplicationControll:error
  include AuthenticateUser
  before_action :authenticate_request!
  respond_to :json

  # get /admin/current_user
  def index
  end
end