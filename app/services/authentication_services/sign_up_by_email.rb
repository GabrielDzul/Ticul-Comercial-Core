module AuthenticationServices
  class SignUpByEmail

    def execute(email:, password:, password_confirmation:)
      user = create_user_by_email(
        email: email,
        password: password,
        password_confirmation: password_confirmation
      )

      UserMailer.welcome(user.id).deliver_later
      user
    end

    private

    def create_user_by_email(email:, password:, password_confirmation:)
      ActiveRecord::Base.transaction do
        raise Error::User::EmailAlreadyRegistered if UserRepository.instance.exists?(email: email)

        new_user = UserRepository.instance.create_from_params!(
          email: email,
          activation_code: SecureRandom.hex
        )
        UserRepository.instance.update_credentials!(
          id: new_user.id,
          password: password,
          password_confirmation: password_confirmation
        )

        new_user.reload
        new_user
      end
    end
  end
end
