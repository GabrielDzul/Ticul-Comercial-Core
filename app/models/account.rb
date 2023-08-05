class Account < ApplicationRecord
  include Attributes::AccountStatus

  attribute :balance,  :decimal, default: 0

  belongs_to :user,
             inverse_of: :accounts

  validates :status,
            presence: true
end
