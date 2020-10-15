require 'rails_helper'

RSpec.describe Bookmark, type: :model do

  describe 'Bookmarkモデルのテスト' do
    context '保存できる場合のテスト' do
      it '保存ができる' do
        bookmark = create(:bookmark)
        expect(bookmark).to be_valid
      end
    end
    context '保存ができない場合のテスト' do
      it '外部キーが空白の場合は保存できない' do
        bookmark = build(:bookmark)
        expect(bookmark).to be_invalid
        bookmark = build(:bookmark)
        expect(bookmark).to be_invalid
      end
      it '外部キーが文字列型の場合は保存できない' do
        bookmark = build(:bookmark, user_id: 1)
        expect(bookmark).to be_invalid
        bookmark = build(:bookmark, restaurant_id: 1)
        expect(bookmark).to be_invalid
      end
    end
  end

end
