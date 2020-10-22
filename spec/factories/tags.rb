FactoryBot.define do

  factory :tag do
    sequence(:name) { |n| "タグ名#{n}" }
  end

end
