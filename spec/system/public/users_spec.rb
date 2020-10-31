require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    create(:user)
    @user = User.find(1)
    sign_in @user
  end
  describe 'showページのテスト' do
    before do
      visit user_mypage_path
    end
    it 'ページが表示される' do
      expect(current_path).to eq user_mypage_path
      expect(page).to have_content @user.name
    end
  end
  describe 'infoページのテスト' do
    before do
      visit user_info_path
    end
    it 'ページが表示される' do
      expect(current_path).to eq user_info_path
      expect(page).to have_content @user.phone_number
      expect(page).to have_content @user.email
    end
    it '1つのリンクにアクセスできる' do
      click_link '登録情報編集'
      expect(current_path).to eq user_edit_path
    end
  end
  describe 'editページのテスト' do
    before do
      visit user_edit_path
    end
    it 'ページが表示される' do
      expect(current_path).to eq user_edit_path
    end
    it '2つのリンクにアクセスできる' do
      click_link 'こちら'
      expect(current_path).to eq new_contact_path
      visit user_edit_path
      click_link '退会する'
      expect(current_path).to eq users_withdraw_path(@user)
    end
    it '"変更を保存する"ボタンを押すとinfoページに遷移' do
      fill_in 'user[phone_number]', with: @user.phone_number
      fill_in 'user[email]', with: @user.email
      click_button '変更を保存'
      expect(current_path).to eq user_info_path
    end
  end
  describe 'profileページのテスト' do
    before do
      visit user_profile_path
    end
    it 'ページが表示される' do
      expect(current_path).to eq user_profile_path
    end
  end
  describe 'withdrawページのテスト' do
    before do
      visit users_withdraw_path(@user)
    end
    it 'ページが表示される' do
      expect(current_path).to eq users_withdraw_path(@user)
    end
    it '1つのリンクにアクセスできる' do
      click_link 'こちら'
      expect(current_path).to eq user_edit_path
    end
    describe '"退会する"ボタンの処理' do
      it 'withdrewページに遷移し、"退会済み"になる' do
        click_button '退会する'
        expect(current_path).to eq users_withdrew_path(@user)
        expect(User.find(1).user_status).to eq 'withdrew'
      end
    end
  end
  describe 'withdrewページのテスト' do
    before do
      visit users_withdraw_path(@user)
      click_button '退会する'
    end
    it 'ページが表示される' do
      expect(current_path).to eq users_withdrew_path(@user)
    end
  end
  describe '_linksページのテスト' do
    context 'public/usersディレクトリ直下ページの場合' do
      it '5つのリンクが表示される' do
        visit user_mypage_path
        click_link 'プロフィールを確認'
        expect(current_path).to eq user_profile_path
        visit user_mypage_path
        click_link '登録情報確認'
        expect(current_path).to eq user_info_path
        visit user_mypage_path
        click_link 'パスワードの変更はこちら'
        expect(current_path).to eq edit_user_registration_path
        visit user_mypage_path
        click_link '現在の予約状況'
        expect(current_path).to eq user_reservations_path(@user)
        visit user_mypage_path
        click_link '予約履歴'
        expect(current_path).to eq user_reservations_path(@user)
      end
    end
    context 'public/users/deviseディレクトリ以下ページの場合' do
      it '2つのリンクが非表示' do
        visit users_sign_up_complete_path
        expect(page).to_not have_content '現在の予約状況'
        expect(page).to_not have_content '予約履歴'
      end
    end
  end
end
