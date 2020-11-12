FactoryBot.define do

  factory :user do
    sequence(:email) { |n| "primary#{n}@example.com" }
    password { "000000" }
    name_family { "田中" }
    name_first { "太郎" }
    name_family_kana { "たなか" }
    name_first_kana { "たろう" }
    profile { "" }
    profile_image_id { "" }
    twitter { "" }
    facebook { "" }
    instagram { "" }
    phone_number { "00000000000" }
    sequence(:email_sub) { |n| "secondary#{n}@example.com.b" }
    birth_year { 1900 }
    birth_month { 1 }
    birth_day { 1 }
    user_status { 0 }
    confirmed_at { DateTime.now }
  end

end
