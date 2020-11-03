require 'rails_helper'

RSpec.describe 'Restaurant', type: :system do
  before do
    @restaurant = create(:restaurant)
    sign_in @restaurant
  end
  describe 'showページのテスト' do
    it '店舗TOP画面が表示される' do
      visit owner_restaurant_path(@restaurant)
      expect(page).to have_content '店舗名'
    end
  end
  describe 'editページのテスト' do
    it '店舗情報編集画面が表示される' do
      visit edit_owner_restaurant_path(@restaurant)
      expect(page).to have_content '店舗情報の編集'
    end
  end
end
