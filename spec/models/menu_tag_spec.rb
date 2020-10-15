require 'rails_helper'

RSpec.describe MenuTag, type: :model do

  describe 'MenuTagモデルのテスト' do
    context '保存できる場合のテスト' do
      it '保存ができる' do
        menu_tag = create(:menu_tag)
        expect(menu_tag).to be_valid
      end
    end
    context '保存ができない場合のテスト' do
      it '外部キーが空白の場合は保存できない' do
        menu_tag = build(:menu_tag, menu_id: nil)
        expect(menu_tag).to be_invalid
        menu_tag = build(:menu_tag, tag_id: nil)
        expect(menu_tag).to be_invalid
      end
      it '外部キーが文字列型の場合は保存できない' do
        menu_tag = build(:menu_tag, menu_id: '１')
        expect(menu_tag).to be_invalid
        menu_tag = build(:menu_tag, tag_id: '１')
        expect(menu_tag).to be_invalid
      end
    end
  end

end
