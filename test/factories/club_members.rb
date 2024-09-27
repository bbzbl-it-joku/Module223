FactoryBot.define do
  factory :club_member do
    association :user
    association :club
    role { "MEMBER" }

    trait :admin do
      role { "ADMIN" }
    end
  end
end
