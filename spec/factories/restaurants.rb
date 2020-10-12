FactoryBot.define do
  factory :restaurant do
    email { "a@a.a" }
    password { "000000" }
    name { "店舗名" }
    restaurant_image_id { "" }
    introduction { "" }
    postal_code { "0000000" }
    phone_number { "00000000000" }
    corporate { "a@a.a" }
    twitter { "" }
    facebook { "" }
    instagram { "" }
    completion_message { "" }
    prefecture { "" }
    city { "" }
    street { "" }
    building { "" }
  end
end
