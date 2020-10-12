require 'rails_helper'

RSpec.describe Restaurant, type: :model do

  describe 'Restaurantモデルのテスト' do
    context '保存ができる場合のテスト' do
      it '保存できる' do
        restaurant = build(:restaurant)
        expect(restaurant).to be_valid
      end
    end
    context '保存ができない場合のテスト' do
      it ':emailが空白の場合は保存できない' do
        restaurant = build(:restaurant, email: nil)
        expect(restaurant).to be_invalid
      end
      it ':emailが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, email: "a@a.a" + ("a" * 255))
        expect(restaurant).to be_invalid
      end
      it ':emailに@がなければ保存できない' do
        restaurant = build(:restaurant, email: 'aa.a')
        expect(restaurant).to be_invalid
      end
      it ':emailに.がなければ保存できない' do
        restaurant = build(:restaurant, email: 'a@a')
        expect(restaurant).to be_invalid
      end
      it ':emailの値が重複する場合は保存できない' do
        restaurant = build(:restaurant)
        restaurant.save
        duplicate_restaurant = build(:restaurant, email: restaurant.email)
        expect(duplicate_restaurant).to be_invalid
      end
      it ':passwordが空白の場合は保存できない' do
        restaurant = build(:restaurant, password: nil)
        expect(restaurant).to be_invalid
      end
      it ':passwordが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, password: "0" * 256)
        expect(restaurant).to be_invalid
      end
      it ':passwordが6文字未満の場合は保存できない' do
        restaurant = build(:restaurant, password: "0" * 5)
        expect(restaurant).to be_invalid
      end
      it ':nameが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, name: "a" * 256)
        expect(restaurant).to be_invalid
      end
      it ':postal_codeが9桁を超える場合は保存できない' do
        restaurant = build(:restaurant, postal_code: "0" * 10)
        expect(restaurant).to be_invalid
      end
      it ':phone_numberが15文字を超える場合は保存できない' do
        restaurant = build(:restaurant, phone_number: "0" * 16)
        expect(restaurant).to be_invalid
      end
      it ':corporateが空白の場合は保存できる' do
        restaurant = build(:restaurant, corporate: nil)
        expect(restaurant).to be_valid
      end
      it ':corporateが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, corporate: "a@a.a" + ("a" * 255))
        expect(restaurant).to be_invalid
      end
      it ':corporateに@がなければ保存できない' do
        restaurant = build(:restaurant, corporate: 'aa.a')
        expect(restaurant).to be_invalid
      end
      it ':corporateに.がなければ保存できない' do
        restaurant = build(:restaurant, corporate: "a@aa")
        expect(restaurant).to be_invalid
      end
      it ':twitterが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, twitter: "a" * 256)
        expect(restaurant).to be_invalid
      end
      it ':facebookが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, facebook: "a" * 256)
        expect(restaurant).to be_invalid
      end
      it ':instagramが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, instagram: "a" * 256)
        expect(restaurant).to be_invalid
      end
      it ':prefectureが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, prefecture: "a" * 256)
        expect(restaurant).to be_invalid
      end
      it ':cityが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, city: "a" * 256)
        expect(restaurant).to be_invalid
      end
      it ':streetが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, street: "a" * 256)
        expect(restaurant).to be_invalid
      end
      it ':buildingが255文字を超える場合は保存できない' do
        restaurant = build(:restaurant, building: "a" * 256)
        expect(restaurant).to be_invalid
      end
    end
  end

end
