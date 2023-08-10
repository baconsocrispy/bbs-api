class User < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  validates :email, presence: true
  validates :encrypted_password, presence: true
  validates :first_name, presence: true
  validates :last_name, presence: true

  # return user's current jwt
  def jwt
    # JWT.encode(payload, secret)
    return JWT.encode(
      { user_id: self.id }, Rails.application.secrets.secret_key_base
    )
  end
end
