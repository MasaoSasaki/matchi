require 'rails_helper'

RSpec.describe 'Tags' do
  before do
    admin = create(:admin)
    sign_in admin
  end
  describe 'indexページのテスト' do
    it 'タグ一覧画面が表示される' do
      visit master_tags_path
      expect(page).to have_content 'タグ一覧'
    end
  end
end
