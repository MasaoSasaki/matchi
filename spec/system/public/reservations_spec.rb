require 'rails_helper'

RSpec.describe 'Reservations', type: :system do
  before do
    @user = create(:user)
    @menu = create(:menu)
    @reservation = create(:reservation)
    sign_in @user
  end
  describe 'indexページのテスト' do
    it '予約履歴が表示される' do
      visit user_reservations_path(@user)
      expect(current_path).to eq user_reservations_path(@user)
    end
  end
  describe 'showページのテスト' do
    it '予約詳細が表示される' do
      visit user_reservation_path(@user, @reservation)
      expect(current_path).to eq user_reservation_path(@user, @reservation)
    end
  end
  describe 'newページのテスト' do
    it '予約画面が表示される' do
      visit new_user_reservation_path(@user, menu_id: @menu)
      expect(current_path).to eq new_user_reservation_path(@user)
    end
  end
  describe 'confirmページのテスト' do
    it '予約確認画面が表示される' do
      visit user_reservations_confirm_path(@user, menu_id: @menu)
      expect(current_path).to eq user_reservations_confirm_path(@user)
    end
  end
  describe 'completionページのテスト' do
    it '予約完了画面が表示される' do
      visit user_reservations_completion_path(@user)
      expect(current_path).to eq user_reservations_completion_path(@user)
    end
  end
end
