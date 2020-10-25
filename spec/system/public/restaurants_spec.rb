require 'rails_helper'

RSpec.describe 'Restaurants' do
  before do
    @restaurant = create(:restaurant)
  end
  describe 'indexページのテスト' do
    it 'レストラン一覧が表示される' do
      visit restaurants_path
      expect(page).to have_content 'レストラン一覧'
    end
  end
  describe 'showページのテスト' do
    it 'レストラン詳細が表示される' do
      visit restaurant_path(@restaurant)
      expect(page).to have_content '店舗紹介'
    end
  end
end
