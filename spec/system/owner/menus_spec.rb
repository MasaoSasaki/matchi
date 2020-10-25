require 'rails_helper'

RSpec.describe 'Restaurant' do
  before do
    @restaurant = create(:restaurant)
    sign_in @restaurant
    @menu = create(:menu, restaurant_id: @restaurant.id)
  end
  describe 'indexページのテスト' do
    it 'メニュー一覧画面が表示される' do
      visit owner_restaurant_menus_path(@restaurant)
      expect(page).to have_content 'Menus'
    end
  end
  describe 'showページのテスト' do
    it 'メニュー詳細画面が表示される' do
      visit owner_restaurant_menu_path(@restaurant, @menu)
      expect(page).to have_content 'メニュー画像'
    end
  end
  describe 'newページのテスト' do
    it 'メニュー新規作成画面が表示される' do
      visit new_owner_restaurant_menu_path(@restaurant)
      expect(page).to have_content 'Create Menu'
    end
  end
  describe 'editページのテスト' do
    it 'メニュー編集画面が表示される' do
      visit edit_owner_restaurant_menu_path(@restaurant, @menu)
      expect(page).to have_content 'メニュー編集'
    end
  end
end
