module Error
  class Unauthorized < Base
    def initialize(message = nil, code: nil, meta: nil)
      super message || I18n.t('status_code.IER4002_not_authorized.message'),
            status: :unauthorized,
            code: code || I18n.t('status_code.IER4002_not_authorized.code'),
            meta: meta
    end
  end
end