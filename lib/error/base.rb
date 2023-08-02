
# Description:
# The Base class aids us in defining a standard
# interface for how we handle the errors in our API.
#
# It has two main functions:
#   1. Hold details of the error thrown so it can
#   be translated to one of the standard HTTP codes.
#   2. Provide a consistent way to "serialize" errors.
#
# Attributes:
# - message: string, Holds a human friendly way to
# describe the error.
# - status: integer, Denotes the HTTP status code.
# - error: string, Similar to message, but this
# field is intended to show the error message from
# a raised error.
# - meta: Hash, Contains a more details about the
# error.

module Error
  class Base < StandardError
    include ActiveModel::Serialization
    attr_reader :meta, :code

    def initialize(message = I18n.t('status_code.IER5000_internal_server_error.message'),
                   status: :internal_server_error,
                   code: I18n.t('status_code.IER5000_internal_server_error.code'),
                   meta: nil)

      super(message)
      @status = status
      @code = code
      @meta = meta
    end

    # returns the error as its hash representation
    def to_hash
      {
        message:,
        code:,
        status:,
        error: self.class.name,
        meta:
      }.compact
    end
    alias to_h to_hash

    def status
      Rack::Utils.status_code(@status)
    rescue NameError
      StatusCodes.status_code(@status)
    end
  end
end
