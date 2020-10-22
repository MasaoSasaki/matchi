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
        bookmark = build(:bookmark, user_id: nil, restaurant_id: 1)
        bookmark.valid?
        expect(bookmark.errors[:user_id]).to include("を入力してください")
        bookmark = build(:bookmark, user_id: 1, restaurant_id: nil)
        bookmark.valid?
        expect(bookmark.errors[:restaurant_id]).to include("を入力してください")
      end
      it '外部キーが文字列型の場合は保存できない' do
        bookmark = build(:bookmark, user_id: 1, restaurant_id: "１")
        bookmark.valid?
        expect(bookmark.errors[:restaurant_id]).to include("は数値で入力してください")
        bookmark = build(:bookmark, user_id: "１", restaurant_id: 1)
        bookmark.valid?
        expect(bookmark.errors[:user_id]).to include("は数値で入力してください")
      end
    end
  end

end
