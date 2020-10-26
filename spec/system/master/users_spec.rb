require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    admin = create(:admin)
    sign_in admin
    @user = create(:user)
  end
  describe 'indexページのテスト' do
    it '会員一覧画面が表示される' do
      visit master_users_path
      expect(page).to have_content '会員一覧'
    end
  end
  describe 'showページのテスト' do
    it '会員詳細画面が表示される' do
      visit master_user_path(@user)
      expect(page).to have_content '会員詳細'
    end
  end
end
