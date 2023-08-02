module Attributes
  module UserStatus
    extend ActiveSupport::Concern

    INCOMPLETE = 'incomplete'.freeze
    COMPLETE = 'complete'.freeze

    included do
      enum status: {
        incomplete: INCOMPLETE,
        complete: COMPLETE,
      }, _suffix: true, _default: INCOMPLETE
    end
  end
end