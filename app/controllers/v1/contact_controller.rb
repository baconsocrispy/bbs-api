class V1::ContactController < ActionController::API
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
    def contact_params
      params.permit(:first_name, :last_name, :email, :phone, :message)
    end
end