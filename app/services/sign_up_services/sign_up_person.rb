module SignUpServices
  class SignUpPerson

    # @param [String] email
    # @param [String] password
    # @param [String] password_confirmation
    # @param [String] phone
    # @return [User]
    def execute(email:, password:, password_confirmation:, phone:)

      user = AccountServices::CreateAccount.new
                                              .execute(phone:,
                                                       email:,
                                                       password:,
                                                       password_confirmation:)

      notify_sign_up_completed user
      user
    end

    private

    def notify_sign_up_completed(user)
      payload = { user_id: user.id }
      ActiveSupport::Notifications.instrument(Events::PERSON_SIGNED_UP, payload)
    end
  end
end
