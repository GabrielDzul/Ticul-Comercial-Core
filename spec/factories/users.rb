FactoryBot.define do
  factory :not_registered_user, class: User do
    status { Attributes::UserStatus::INCOMPLETE }

    factory :user, aliases: [:incomplete_user] do
      name { Faker::Name.first_name }
      paternal_surname { Faker::Name.last_name }
      maternal_surname { Faker::Name.last_name }
      email { Faker::Internet.email }

      trait :unverified do
        activation_date { nil }
        activation_code { nil }
      end
    end
  end
end
