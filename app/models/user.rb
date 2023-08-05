class User < ApplicationRecord
  include Attributes::UserStatus

  attribute :blocked, :boolean, default: false
  attribute :verified, :boolean, default: false

  has_one :user_credential,
          dependent: :destroy

  has_many :accounts,
           dependent: :destroy

  validates :status,
            presence: true

  validates :activation_code,
            uniqueness: { allow_nil: true }

  validates :phone,
            allow_blank: true,
            uniqueness: true,
            format: { with: RegexConstants::MEXICAN_PHONE }

  validates :name,
            allow_nil: true,
            length: { minimum: 1 },
            format: { with: RegexConstants::PROPER_NOUN }

  validates :paternal_surname,
            allow_nil: true,
            length: { minimum: 1 },
            format: { with: RegexConstants::PROPER_NOUN }

  validates :maternal_surname,
            allow_nil: true,
            format: { with: RegexConstants::PROPER_NOUN }

  validates :email,
            format: { with: URI::MailTo::EMAIL_REGEXP },
            uniqueness: true,
            presence: true

  def email=(value)
    super(value.try(:downcase))
  end

  def email_confirmed?
    activation_code.nil? && activation_date.present?
  end
end
