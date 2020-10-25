require 'rails_helper'

RSpec.describe 'Restaurants' do
  before do
    admin = create(:admin)
    sign_in admin
  end
  describe 'indexページのテスト' do
    it '店舗一覧画面が表示される' do
      visit master_restaurants_path
      expect(page).to have_content '店舗一覧'
    end
  end
end
