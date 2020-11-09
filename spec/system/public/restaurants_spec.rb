require 'rails_helper'

RSpec.describe 'Restaurants', type: :system do
  before do
    @restaurant = create(:restaurant)
    visit restaurants_path
  end
  describe 'indexページのテスト' do
    it 'ページが表示される' do
      expect(page).to have_css '.public-restaurants-index'
    end
    it '店舗詳細にアクセスできる' do
      find('.restaurant0--name').click
      expect(current_path).to eq restaurant_path(@restaurant)
      visit restaurants_path
      find('.restaurant0--image').click
      expect(current_path).to eq restaurant_path(@restaurant)
    end
  end
  describe 'showページのテスト' do
    before do
      visit restaurant_path(@restaurant)
    end
    it 'ページが表示される' do
      expect(page).to have_css '.public-restaurants-show'
    end
    it '1つのリンクが表示される' do
      within('.public-restaurants-show') do
        click_link 'メニュー一覧'
        expect(current_path).to eq menus_path
      end
    end
  end
end
