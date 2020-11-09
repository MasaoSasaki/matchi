require 'rails_helper'

RSpec.describe 'Reservations', type: :system do
  before do
    @restaurant = create(:restaurant)
    sign_in @restaurant
    @menu = create(:menu, restaurant_id: @restaurant.id)
    @reservation = create(:reservation)
  end
  describe 'indexページのテスト' do
    it 'ページが表示される' do
      visit owner_reservations_path
      expect(page).to have_css '.owner-reservations-index'
    end
  end
  describe 'showページのテスト' do
    it 'ページが表示される' do
      visit owner_reservation_path(@reservation)
      expect(page).to have_css '.owner-reservations-show'
    end
  end
end
