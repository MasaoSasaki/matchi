require 'rails_helper'

RSpec.describe 'Admins', type: :system do
  describe 'admins直下ページのテスト' do
    before do
      admin = create(:admin)
      sign_in admin
      visit master_path
    end
    describe 'topページのテスト' do
      it 'ページが表示される' do
        expect(page).to have_css '.master-admins-top'
      end
      it '3つのリンクにアクセスできる' do
        click_link '会員一覧・編集'
        expect(current_path).to eq master_users_path
        visit master_path
        click_link '店舗一覧・編集・新規登録'
        expect(current_path).to eq master_restaurants_path
        visit master_path
        click_link 'タグ一覧・編集・新規登録'
        expect(current_path).to eq master_tags_path
      end
    end
  end
  describe 'devise配下ページのテスト' do
    before do
      @admin = create(:admin)
      visit new_master_admin_session_path
    end
    describe 'sessionsのテスト' do
      describe 'newページのテスト' do
        it 'ページが表示される' do
          expect(page).to have_css '.master-admins-sessions-new'
        end
        it 'ログインに成功する' do
          fill_in 'master_admin[email]', with: @admin.email
          fill_in 'master_admin[password]', with: @admin.password
          click_button 'ログイン'
          expect(current_path).to eq master_path
        end
      end
    end
  end
end
