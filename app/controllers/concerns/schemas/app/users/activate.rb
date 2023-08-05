module Schemas
  module App
    module Users
      class Activate < Dry::Validation::Contract
        schema do
          required(:activation_code).filled(:string)
        end
      end
    end
  end
end
