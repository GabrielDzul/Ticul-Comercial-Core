module Schemas
  module App
    module SignUp
      class Create < Dry::Validation::Contract

        schema do
          required(:email).filled(:string, format?: URI::MailTo::EMAIL_REGEXP)
          required(:phone).filled(Types::StrippedPhone)
          required(:name).filled(Types::StrippedString, format?: RegexConstants::PROPER_NOUN)
          required(:paternal_surname).filled(Types::StrippedString, format?: RegexConstants::PROPER_NOUN)
          required(:maternal_surname).filled(Types::StrippedString, format?: RegexConstants::PROPER_NOUN)
        end
      end
    end
  end
end
