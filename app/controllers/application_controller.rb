class ApplicationController < ActionController::API
  include ActionController::Cookies
  
  # doorkeeper
  before_action :doorkeeper_authorize!
  
  private
  def current_resource_owner
    User.find(doorkeeper_token.resource_owner_id) if doorkeeper_token
  end
end
