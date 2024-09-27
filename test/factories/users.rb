FactoryBot.define do
  factory :user do
    sequence(:username) { |n| "user#{n}" }
    sequence(:email) { |n| "user#{n}@example.com" }
    password { "password1234" }
    password_confirmation { "password1234" }
    role { "USER" }

    trait :admin do
      role { "ADMIN" }
    end
  end
end
