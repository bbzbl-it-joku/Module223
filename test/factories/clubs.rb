FactoryBot.define do
  factory :club do
    sequence(:name) { |n| "Club #{n}" }
    description { "A test club" }
    association :created_by, factory: :user
  end
end
