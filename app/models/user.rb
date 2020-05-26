# frozen_string_literal: true

class User < ActiveRecord::Base
  include DeviseTokenAuth::Concerns::User

  PASSWORD_FORMAT = /\A(?=.*[a-z])(?=.*[A-Z])(?=.*\d)[a-zA-Z\d]{8,}\z/

  devise :database_authenticatable, :recoverable,
    :rememberable, :validatable, :omniauthable, omniauth_providers: %i[facebook google_oauth2]

  validates :password, format: PASSWORD_FORMAT, if: ->{ self.password.present? }

  def token_validation_response
    {
      id: id,
      email: email,
      uid: uid,
      image: image,
      settings: settings,
      typ: self.class.name,
    }
  end
end
