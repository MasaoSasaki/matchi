require 'rails_helper'

RSpec.describe Menu, type: :model do

  describe 'Menuモデルのテスト' do
    context '保存ができる場合のテスト' do
      it '保存できる' do
        menu = create(:menu)
        expect(menu).to be_valid
      end
    end
    context '保存ができない場合のテスト' do
      it '外部キーが空白の場合は保存できない' do
        reservation = build(:menu, restaurant_id: nil)
        expect(reservation).to be_invalid
      end
      it ':restaurant_idが空白の場合は保存できない' do
        menu = build(:menu, restaurant_id: nil)
        expect(menu).to be_invalid
      end
      it ':restaurant_idが文字列の場合は保存できない' do
        menu = build(:menu, restaurant_id: '１')
        expect(menu).to be_invalid
      end
      it ':titleが空白の場合は保存できない' do
        manu = build(:menu, title: nil)
        expect(manu).to be_invalid
      end
      it ':titleが255文字を超える場合は保存できない' do
        manu = build(:menu, title: 'a' * 256)
        expect(manu).to be_invalid
      end
      it ':menu_image_idが255文字を超える場合は保存できない' do
        manu = build(:menu, menu_image_id: 'a' * 256)
        expect(manu).to be_invalid
      end
      it ':regular_priceが空白の場合は保存できない' do
        manu = build(:menu, regular_price: nil)
        expect(manu).to be_invalid
      end
      it ':regular_priceが文字列型の場合は保存できない' do
        manu = build(:menu, regular_price: '１００')
        expect(manu).to be_invalid
      end
      it ':discount_priceが空白の場合は保存できない' do
        manu = build(:menu, discount_price: nil)
        expect(manu).to be_invalid
      end
      it ':discount_priceが文字列型の場合は保存できない' do
        manu = build(:menu, discount_price: '１００')
        expect(manu).to be_invalid
      end
      it ':reservation_methodが空白の場合は保存できない' do
        manu = build(:menu, reservation_method: "")
        expect(manu).to be_invalid
      end
      it ':is_sale_fragが空白の場合は保存できない' do
        manu = build(:menu, is_sale_frag: nil)
        expect(manu).to be_invalid
      end
    end
  end

end
