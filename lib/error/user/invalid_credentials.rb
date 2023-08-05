module Error
  module User
    class InvalidCredentials < ::Error::Unauthorized
      def initialize(message = nil)
        super message || I18n.t('status_code.IER4016_invalid_credentials.message'),
              code: I18n.t('status_code.IER4016_invalid_credentials.code')
      end
    end
  end
end