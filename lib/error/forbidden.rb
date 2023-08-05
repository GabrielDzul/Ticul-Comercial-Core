module Error
  class Forbidden < Base
    def initialize(message = nil, code: nil, meta: nil)
      super message || I18n.t('status_code.IER4005_forbidden.message'),
            status: :forbidden,
            code: code || I18n.t('status_code.IER4005_forbidden.code'),
            meta: meta
    end
  end
end
