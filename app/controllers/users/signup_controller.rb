class Users::SignupController < ActionController::API
  before_action :doorkeeper_authorize!

  # POST
  def create
    @user = User.new(user_params)
    if @user.save!
      render json: serialize_user(@user), status: :ok
    else
      render json: @user.errors, status: :unprocessable_entity
    end
  end

  private 
    # Only allow a list of trusted parameters through.
    def user_params
      params.permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end

    # serialize response
    def serialize_user(user)
      UserSerializer.new(user).serializable_hash[:data][:attributes]
    end
end