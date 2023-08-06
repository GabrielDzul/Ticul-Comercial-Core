module SignUpServices
  class SignUpPerson

    def execute(user, **user_data)
      raise Error::UnprocessableEntity if user.email_confirmed?

      updated_user = update_data(user, **user_data)
      ActiveSupport::Notifications.instrument(Events::PERSON_SIGNED_UP, { user: updated_user})
      updated_user
    end

    private
    def update_data(user, **user_data)
      ActiveRecord::Base.transaction do
        updated_user = UserRepository.instance.update_from_params!(id: user.id, **user_data)
        AccountRepository.instance.create_from_params!(
          user:user
        )
        updated_user.reload
        updated_user
      end
    end
    end
end
