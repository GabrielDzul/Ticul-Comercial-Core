module Schemas
  module App
    module Users
      class Create < Dry::Validation::Contract
        schema do
          required(:email).filled(Types::Email)
          required(:phone).filled(Types::StrippedPhone)
          required(:password).filled(:string)
          required(:password_confirmation).filled(:string)
        end

        rule(:password, :password_confirmation) do
          key.failure('password and password_confirmation must be the same') if values[:password] != values[:password_confirmation]
        end
      end
    end
  end
end
