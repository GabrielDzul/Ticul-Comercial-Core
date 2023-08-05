FactoryBot.define do
  factory :not_registered_user, class: User do
    status { Attributes::UserStatus::INCOMPLETE }

    factory :user, aliases: [:incomplete_user] do
      name { Faker::Name.first_name }
      paternal_surname { Faker::Name.last_name }
      maternal_surname { Faker::Name.last_name }
      email { Faker::Internet.email }
      phone { "+52#{Faker::Number.number(digits: 10)}" }

      trait :unverified do
        activation_date { nil }
        activation_code { nil }
      end
    end

    factory :complete_user do
      name { Faker::Name.first_name }
      paternal_surname { Faker::Name.last_name }
      maternal_surname { Faker::Name.last_name }
      email { Faker::Internet.email }
      activation_date { Faker::Time.backward(days: 2) }
      activation_code { nil }
      status { Attributes::UserStatus::COMPLETE }
      phone { "+52#{Faker::Number.number(digits: 10)}" }

      factory :complete_user_with_credential do
        association :user_credential, factory: :user_credential
      end
    end
  end
end
