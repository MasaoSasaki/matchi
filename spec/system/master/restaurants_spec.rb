require 'rails_helper'

RSpec.describe 'Restaurants', type: :system do
  before do
    @restaurant = create(:restaurant)
    admin = create(:admin)
    sign_in admin
  end
  describe 'indexページのテスト' do
    before do
      visit master_restaurants_path
    end
    it 'ページが表示される' do
      expect(page).to have_css '.master-restaurants-index'
    end
    it '2つのリンクにアクセスできる' do
      click_link @restaurant.id
      expect(current_path).to eq owner_restaurant_path(@restaurant)
      visit master_restaurants_path
      click_link @restaurant.name
      expect(current_path).to eq owner_restaurant_path(@restaurant)
      visit master_restaurants_path
      click_link 'パスワードの変更はこちら'
      expect(current_path).to eq owner_restaurant_session_path
    end
    it '店舗が新規作成できる' do
      fill_in 'restaurant[email]', with: 'test@test.com'
      click_button '登録'
      expect(page).to have_content '店舗を登録しました。'
    end
  end
end
