require 'rails_helper'

RSpec.describe 'Reservations' do
  before do
    @user = create(:user)
    @menu = create(:menu)
    @reservation = create(:reservation)
    sign_in @user
  end
  describe 'indexページのテスト' do
    it '予約履歴が表示される' do
      visit user_reservations_path(@user)
      expect(page).to have_content '予約履歴'
    end
  end
  describe 'showページのテスト' do
    it '予約詳細が表示される' do
      visit user_reservation_path(@user, @reservation)
      expect(page).to have_content 'ご予約の詳細'
    end
  end
  describe 'newページのテスト' do
    it '予約画面が表示される' do
      visit new_user_reservation_path(@user, menu_id: @menu)
      expect(page).to have_content '予約情報の入力'
    end
  end
  describe 'confirmページのテスト' do
    it '予約確認画面が表示される' do
      visit user_reservations_confirm_path(@user, menu_id: @menu)
      expect(page).to have_content '予約情報の確認'
    end
  end
  describe 'completionページのテスト' do
    it '予約完了画面が表示される' do
      visit user_reservations_completion_path(@user)
      expect(page).to have_content 'ご予約は確定済みです！'
    end
  end
end
