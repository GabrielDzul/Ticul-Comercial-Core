module AuthenticationServices
  #
  # Represents the workflow for updating an user password
  #
  class CreatePassword
    def initialize
      @repo = UserRepository.instance
    end

    def execute(user, password:, password_confirmation:)
      raise Error::User::InvalidCredentials if credentials?(user)

      update_credentials(user, password, password_confirmation)
    end

    private

    def update_credentials(user, password, password_confirmation)
      @repo.update_credentials!(
        id: user.id,
        password: password,
        password_confirmation: password_confirmation
      )
    end

    def credentials?(user)
      user.user_credential.present? &&
        user.user_credential.password_digest.present?
    end
  end
end
