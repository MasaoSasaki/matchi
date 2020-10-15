FactoryBot.define do
  factory :menu_tag do
    association :menu
    association :tag
  end
end
