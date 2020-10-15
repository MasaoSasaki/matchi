FactoryBot.define do

  factory :user do
    email { "a@a.a" }
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
    email_sub { "b@b.b" }
    birth_year { 1900 }
    birth_month { 1 }
    birth_day { 1 }
    user_status { 0 }
  end

end
