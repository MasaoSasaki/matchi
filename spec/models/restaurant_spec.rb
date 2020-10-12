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
      it ':emailに@がなければ保存できない' do
        restaurant = build(:restaurant, email: 'aa.a')
        expect(restaurant).to be_invalid
      end
      it ':emailに.がなければ保存できない' do
        restaurant = build(:restaurant, email: 'a@a')
        expect(restaurant).to be_invalid
      end
      it ':emailの値が空白の場合は保存できない' do
        restaurant = build(:restaurant, email: nil)
        expect(restaurant).to be_invalid
      end
      it ':emailの値が重複する場合は保存できない' do
        restaurant = build(:restaurant)
        restaurant.save
        duplicate_restaurant = build(:restaurant, email: restaurant.email)
        expect(duplicate_restaurant).to be_invalid
      end
    end
  end

end
