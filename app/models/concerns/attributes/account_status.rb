module Attributes
  module AccountStatus
    extend ActiveSupport::Concern

    ACTIVE   = 'active'.freeze
    BLOCKED  = 'blocked'.freeze
    INACTIVE = 'inactive'.freeze

    included do
      enum status: {
        active: ACTIVE,
        inactive: INACTIVE,
        blocked: BLOCKED
      }, _suffix: true, _default: INACTIVE
    end
  end
end
