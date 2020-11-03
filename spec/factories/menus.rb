FactoryBot.define do

  factory :menu do
    association :restaurant
    title { "タイトル" }
    menu_image { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec/fixtures/test_menu_image.jpg'), 'image/jpg') }
    content { "" }
    cancel { "" }
    regular_price { 100 }
    discount_price { 100 }
    reservation_method { 0 }
    is_sale_frag { true }
  end
end
