# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  respond_to :json

  private
  def respond_with(resource, _opts = {})
    if resource.persisted?
      render json: {
        status: {
          code: 200,
          message: 'Signup success'
        },
        jwt: resource.jwt
      }, status: :ok
    else
      render json: {
        status: {
          message: "#{
            resource.errors.full_messages.to_sentence
          }",
          errors: resource.errors
        }, 
      }, status: :unprocessable_entity  
    end
  end

  private
  def sign_up_params
    params.require(:user).permit(:email, :password, :password_confirmation)
  end
end
