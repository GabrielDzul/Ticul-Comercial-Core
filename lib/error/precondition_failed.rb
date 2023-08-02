module Error
  class PreconditionFailed < Base
    def initialize(message = nil, code: nil, meta: nil)
      super message || I18n.t('status_code.IER4010_precondition_failed.message'),
            status: :precondition_failed,
            code: code || I18n.t('status_code.IER4010_precondition_failed.code'),
            meta: meta
    end
  end
end
