module Error
  module User
    class EmailAlreadyRegistered < ::Error::Forbidden
      def initialize(message = nil)
        super message || I18n.t('status_code.IER4404_user_email_already_registered.message'),
              code: I18n.t('status_code.IER4404_user_email_already_registered.code')
      end
    end
  end
end