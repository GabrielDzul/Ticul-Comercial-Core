module Error
  class InvalidResource < Error::UnprocessableEntity
    def initialize(message = nil,
                   code: nil,
                   meta: nil,
                   validation_errors: nil)
      super message || I18n.t('status_code.IER4006_invalid_resource.message'),
            code: code || I18n.t('status_code.IER4006_invalid_resource.code'),
            meta: meta || {
              validation_errors: validation_errors,
            }
    end
  end
end
