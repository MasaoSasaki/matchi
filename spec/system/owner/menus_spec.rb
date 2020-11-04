require 'rails_helper'

RSpec.describe 'Menus', type: :system do
  before do
    @menu = create(:menu)
    @restaurant = @menu.restaurant
    sign_in @restaurant
  end
  describe 'indexページのテスト' do
    before do
      visit owner_restaurant_menus_path(@restaurant)
    end
    it 'ページが表示される' do
      expect(current_path).to eq owner_restaurant_menus_path(@restaurant)
    end
    it '3つのリンクにアクセスできる' do
      all('.menu-image-path')[0].click
      expect(current_path).to eq owner_restaurant_menu_path(@restaurant, @menu)
      visit owner_restaurant_menus_path(@restaurant)
      all('.menu-title-path')[0].click
      expect(current_path).to eq owner_restaurant_menu_path(@restaurant, @menu)
      visit owner_restaurant_menus_path(@restaurant)
      click_link 'メニュー新規追加'
      expect(current_path).to eq new_owner_restaurant_menu_path(@restaurant)
    end
    it 'ログインしている店舗管理者しか"メニュー新規追加"がクリックできない' do
      visit owner_restaurant_menus_path(restaurant_id: 2)
      expect(page).to have_no_link 'メニュー新規追加'
    end
  end
  describe 'showページのテスト' do
    before do
      visit owner_restaurant_menu_path(@restaurant, @menu)
    end
    it 'ページが表示される' do
      expect(current_path).to eq owner_restaurant_menu_path(@restaurant, @menu)
    end
    it '2つのリンクにアクセスできる' do
      click_link '編集'
      expect(current_path).to eq edit_owner_restaurant_menu_path(@restaurant, @menu)
      visit owner_restaurant_menu_path(@restaurant, @menu)
      click_link '一覧に戻る'
      expect(current_path).to eq owner_restaurant_menus_path(@restaurant)
    end
    it 'ログインしている店舗管理者しか編集・削除が表示されない' do
      click_link '店舗ログアウト'
      visit owner_restaurant_menu_path(@restaurant, @menu)
      expect(page).to_not have_content '削除'
      visit owner_restaurant_menu_path(@restaurant, @menu)
      expect(page).to_not have_content '編集'
    end
  end
  describe 'newページのテスト' do
    before do
      visit new_owner_restaurant_menu_path(@restaurant)
    end
    it 'ページが表示される' do
      expect(current_path).to eq new_owner_restaurant_menu_path(@restaurant)
    end
  end
  describe 'editページのテスト' do
    before do
      visit edit_owner_restaurant_menu_path(@restaurant, @menu)
    end
    it 'ページが表示される' do
      expect(current_path).to eq edit_owner_restaurant_menu_path(@restaurant, @menu)
    end
  end
end
