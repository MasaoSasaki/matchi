require 'rails_helper'

RSpec.describe 'Users' do
  before do
    @user = create(:user)
    sign_in @user
  end
  describe 'showページのテスト' do
    it 'マイページが表示される' do
      visit user_mypage_path
      expect(page).to have_content 'My Page'
    end
  end
  describe 'infoページのテスト' do
    it '登録情報が表示される' do
      visit user_info_path
      expect(page).to have_content '登録情報'
    end
  end
  describe 'editページのテスト' do
    it '登録情報編集が表示される' do
      visit user_edit_path
      expect(page).to have_content '登録情報編集'
    end
  end
  describe 'profileページのテスト' do
    it 'プロフィールが表示される' do
      visit user_profile_path
      expect(page).to have_content 'プロフィール'
    end
  end
  describe 'withdrawページのテスト' do
    it '退会確認画面が表示される' do
      visit users_withdraw_path(@user)
      expect(page).to have_content '本当に退会しますか？'
    end
  end
  describe 'withdrewページのテスト' do
    it '退会完了画面が表示される' do
      visit users_withdrew_path(@user)
      expect(page).to have_content '退会が完了しました。'
    end
  end
end
