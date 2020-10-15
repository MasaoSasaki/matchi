FactoryBot.define do
  factory :bookmark do
    association :user
    association :restaurant
  end
end
