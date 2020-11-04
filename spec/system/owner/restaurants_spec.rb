require 'rails_helper'

RSpec.describe 'Restaurant', type: :system do
  before do
    @restaurant = create(:restaurant)
    sign_in @restaurant
  end
  describe 'showページのテスト' do
    before do
      visit owner_restaurant_path(@restaurant)
    end
    it 'ページが表示される' do
      expect(current_path).to eq owner_restaurant_path(@restaurant)
    end
    it '3つのリンクにアクセスできる' do
      click_link 'メニュー一覧・編集'
      expect(current_path).to eq owner_restaurant_menus_path(@restaurant)
      visit owner_restaurant_path(@restaurant)
      click_link '予約履歴'
      expect(current_path).to eq owner_reservations_path
      visit owner_restaurant_path(@restaurant)
      click_link '店舗情報編集'
      expect(current_path).to eq edit_owner_restaurant_path(@restaurant)
    end
  end
  describe 'editページのテスト' do
    before do
      visit edit_owner_restaurant_path(@restaurant)
    end
    it 'ページが表示される' do
      expect(current_path).to eq edit_owner_restaurant_path(@restaurant)
    end
    it '2つのリンクにアクセスできる' do
      click_link '店舗情報に戻る'
      expect(current_path).to eq owner_restaurant_path(@restaurant)
      visit edit_owner_restaurant_path(@restaurant)
      click_link 'パスワードの変更はこちら'
      expect(current_path).to eq edit_owner_restaurant_registration_path(@restaurant)
    end
    describe '"更新"ボタンのテスト' do
      it '更新に成功する' do
        within('.owner-restaurants-edit-pc') do
          click_button '更新'
          expect(current_path).to eq owner_restaurant_path(@restaurant)
        end
        visit edit_owner_restaurant_path(@restaurant)
        within('.owner-restaurants-edit-sp') do
          click_button '更新'
          expect(current_path).to eq owner_restaurant_path(@restaurant)
        end
      end
      it '更新に失敗する' do
        within('.owner-restaurants-edit-pc') do
          fill_in 'restaurant[name]', with: nil
          click_button '更新'
          expect(page).to have_content '店舗名を入力してください'
        end
        visit edit_owner_restaurant_path(@restaurant)
        within('.owner-restaurants-edit-sp') do
          fill_in 'restaurant[name]', with: nil
          click_button '更新'
          expect(page).to have_content '店舗名を入力してください'
        end
      end
    end
  end
end
