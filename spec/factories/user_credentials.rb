FactoryBot.define do
  factory :user_credential do
    password_str = 'p4ssW0rd!'
    password { password_str }
    password_confirmation { password_str }

    association :user, factory: :complete_user
  end
end
