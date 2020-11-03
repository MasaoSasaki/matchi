require 'rails_helper'

RSpec.describe 'Users', type: :system do
  before do
    admin = create(:admin)
    sign_in admin
    @user = create(:user)
  end
  describe 'indexページのテスト' do
    before do
      visit master_users_path
    end
    it 'ページが表示される' do
      expect(current_path).to eq master_users_path
    end
    it 'showページに遷移できる' do
      click_link @user.name
      expect(current_path).to eq master_user_path(@user)
    end
    it '"会員ステータス"が表示されている' do
      expect(page).to have_content @user.user_status_i18n
    end
  end
  describe 'showページのテスト' do
    before do
      visit master_users_path
      click_link @user.name
    end
    it 'ページが表示される' do
      visit master_user_path(@user)
      expect(current_path).to eq master_user_path(@user)
    end
    describe '会員ステータス更新のテスト' do
      it '更新が反映される' do
        select '有効会員', from: '会員ステータス'
        click_button '更新する'
        expect(page).to have_content '有効会員'
        visit master_user_path(@user)
        select '退会済み', from: '会員ステータス'
        click_button '更新する'
        expect(page).to have_content '退会済み'
        visit master_user_path(@user)
        select '強制退会', from: '会員ステータス'
        click_button '更新する'
        expect(page).to have_content '強制退会'
      end
    end
  end
end
