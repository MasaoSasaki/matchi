FactoryBot.define do
  factory :menu do
    association :restaurant
    id { 1 }
    title { "タイトル" }
    menu_image_id { "" }
    content { "" }
    cancel { "" }
    regular_price { 100 }
    discount_price { 100 }
    reservation_method { 0 }
    is_sale_frag { true }
  end
end
