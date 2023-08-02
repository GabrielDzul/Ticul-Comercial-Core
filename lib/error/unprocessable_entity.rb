module Error
  class UnprocessableEntity < Base
    def initialize(message = nil, code: nil, meta: nil)
      super message || I18n.t('status_code.IER4222_unprocessable_entity.message'),
            status: :unprocessable_entity,
            code: code || I18n.t('status_code.IER4222_unprocessable_entity.code'),
            meta: meta
    end
  end
end
