module AccountServices
  class CreateAccount

    # @param [String] email
    # @param [String] password
    # @param [String] password_confirmation
    # @param [String] phone
    # @return [User]
    def execute(email:, phone:, password:, password_confirmation:)
      create_account(email:,phone:, password:, password_confirmation:)
    end

    private

    def create_account(email:, phone:, password:, password_confirmation:)
      ActiveRecord::Base.transaction do
        user = create_user!(email: email, phone: phone)
        create_password(user:, password:, password_confirmation:)
      end
    end

    def create_user!(email:, phone:)
      user = UserRepository.instance.create_from_params!(
        email: email,
        phone: phone
      )
      AccountRepository.instance.create_from_params!(
        user:user
      )
      user
    end

    def create_password(user:, password:, password_confirmation:)
      AuthenticationServices::CreatePassword.new
                                            .execute(user,
                                                     password:,
                                                     password_confirmation:)
    end
  end
end
