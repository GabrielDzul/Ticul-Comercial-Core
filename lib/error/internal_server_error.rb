module Error
  class InternalServerError < Base
    def initialize(message = nil, code: nil, meta: nil)
      super message || I18n.t('status_code.IER5000_internal_server_error.message'),
            status: :internal_server_error,
            code: code || I18n.t('status_code.IER5000_internal_server_error.code'),
            meta: meta
    end
  end
end
