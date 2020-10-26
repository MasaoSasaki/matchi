require 'rails_helper'

RSpec.describe 'Reservations', type: :system do
  before do
    @restaurant = create(:restaurant)
    sign_in @restaurant
    @menu = create(:menu, restaurant_id: @restaurant.id)
    @reservation = create(:reservation)
  end
  describe 'indexページのテスト' do
    it '予約一覧画面が表示される' do
      visit owner_reservations_path
      expect(page).to have_content 'Reservated List'
    end
  end
  describe 'showページのテスト' do
    it '予約詳細画面が表示される' do
      visit owner_reservation_path(@reservation)
      expect(page).to have_content '予約の詳細'
    end
  end
end
