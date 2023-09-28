class V1::ContactController < ActionController::API
  def create
    first_name = params[:first_name]
    last_name = params[:last_name]
    email = params[:email]
    phone = params[:phone]
    message = params[:message]

    begin
      ContactMailer.send_email(first_name, last_name, email, phone, message).deliver_now
      render json: { success: true }, response: :ok
    rescue => error
      puts error
      render json: { success: false }, response: :unprocessable_entity
    end
  end

  private 
    # Only allow a list of trusted parameters through.
    def contact_params
      params.permit(:first_name, :last_name, :email, :phone, :message)
    end
end