require 'rails_helper'

RSpec.describe 'Menus' do
  before do
    @menu = create(:menu)
  end
  describe 'indexページのテスト' do
    it 'メニュー一覧が表示される' do
      visit menus_path
      expect(page).to have_content 'メニュー一覧'
    end
  end
  describe 'showページのテスト' do
    it 'メニュー詳細が表示される' do
      visit menu_path(@menu)
      expect(page).to have_content 'メニュー内容'
    end
  end
end
