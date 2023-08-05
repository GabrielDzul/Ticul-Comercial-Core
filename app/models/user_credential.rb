class UserCredential < ApplicationRecord
  PASSWORD_MIN_LENGTH = 8

  has_secure_password

  belongs_to :user

  validates :password,
            allow_blank: true,
            confirmation: true,
            length: { minimum: PASSWORD_MIN_LENGTH }
end
