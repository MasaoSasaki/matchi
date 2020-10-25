require 'rails_helper'

RSpec.describe 'Admins' do
  before do
    admin = create(:admin)
    sign_in admin
  end
  describe 'topページのテスト' do
    it '管理者トップ画面が表示される' do
      visit master_path
      expect(page).to have_content '管理者画面'
    end
  end
end
