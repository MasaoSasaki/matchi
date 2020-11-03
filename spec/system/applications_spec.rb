require 'rails_helper'

RSpec.describe 'Applications', type: :system do
  describe 'ヘッダーのテスト(ログイン状態共通)' do
    before do
      visit root_path
    end
    context 'PC画面' do
      it 'ヘッダーロゴのテスト' do
        all('img[alt="header-logo"]')[1].click
        expect(current_path).to eq root_path
      end
    end
    context 'SP画面' do
      it 'ヘッダーロゴのテスト' do
        within('.sp-header') do
          click_on 'header-logo'
          expect(current_path).to eq root_path
        end
      end
      describe 'リンクのテスト' do
        it '3つのリンクにアクセスできる' do
          within('.hamburger-menu') do
            click_link 'サービス紹介'
            expect(current_path).to eq about_path
            visit root_path
            all('.restaurants-index')[0].click
            expect(current_path).to eq restaurants_path
            visit root_path
            all('.menus-index')[0].click
            expect(current_path).to eq menus_path
          end
        end
      end
    end
  end

  describe 'headerのテスト(ログイン済み)' do
    before do
      @admin = create(:admin)
      sign_in @admin
      @restaurant = create(:restaurant)
      sign_in @restaurant
      @user = create(:user)
      sign_in @user
      visit root_path
    end
    context 'PC画面' do
      describe 'リンクのテスト' do
        context 'adminの場合' do
          it '2つのボタンが表示' do
            click_link '管理者TOP'
            expect(current_path).to eq master_path
            visit root_path
            click_link '管理者ログアウト'
            expect(current_path).to eq new_master_admin_session_path
          end
        end
        context 'restaurantの場合' do
          it '2つのボタンが表示' do
            click_link '店舗TOP'
            expect(current_path).to eq owner_restaurant_path(@restaurant)
            visit root_path
            click_link '店舗ログアウト'
            expect(current_path).to eq new_owner_restaurant_session_path
          end
        end
        context 'userの場合' do
          it '2つのボタンが表示' do
            all('.user-mypage')[0].click
            expect(current_path).to eq user_mypage_path
            visit root_path
            all('.user-sign_out')[0].click
            expect(current_path).to eq root_path
          end
          it '2つのボタンが非表示' do
            expect(page).to_not have_content '新規登録'
            expect(page).to_not have_content 'ログイン'
          end
        end
      end
    end
    context 'SP画面' do
      describe 'リンクのテスト' do
        it '2つのリンクが表示' do
          all('.user-mypage')[1].click
          expect(current_path).to eq user_mypage_path
          visit root_path
          all('.user-sign_out')[1].click
          expect(current_path).to eq root_path
        end
        it '2つのリンクが非表示' do
          expect(page).to_not have_content '新規登録'
          expect(page).to_not have_content 'ログイン'
        end
      end
    end
  end

  describe 'headerのテスト(未ログイン)' do
    before do
      visit root_path
    end
    context 'PC画面' do
      describe 'リンクのテスト' do
        context 'adminの場合' do
          it '2つのボタンが非表示' do
            expect(page).to_not have_content '管理者TOP'
            expect(page).to_not have_content '管理者ログアウト'
          end
        end
        context 'restaurantの場合' do
          it '2つのボタンが非表示' do
            expect(page).to_not have_content '店舗TOP'
            expect(page).to_not have_content '店舗ログアウト'
          end
        end
        context 'userの場合' do
          it '2つのボタンが非表示' do
            expect(page).to_not have_content 'My Page'
            expect(page).to_not have_content 'ログアウト'
          end
          it '2つのボタンが表示' do
            all('.user-sign_up')[0].click
            expect(current_path).to eq new_user_registration_path
            visit root_path
            all('.user-sign_in')[0].click
            expect(current_path).to eq new_user_session_path
          end
        end
      end
    end
    context 'SP画面' do
      describe 'リンクのテスト' do
        it '2つのリンクが非表示' do
          expect(page).to_not have_content 'MyPage'
          expect(page).to_not have_content 'ログアウト'
        end
      end
    end
  end

  describe 'footerのテスト' do
    before do
      visit root_path
    end
    it '全てのリンクにアクセスできる' do
      within('footer') do
        click_on 'footer-logo'
        expect(current_path).to eq root_path
        visit root_path
        click_link 'お問い合わせ'
        expect(current_path).to eq new_contact_path
        visit root_path
        click_link '利用規約'
        expect(current_path).to eq terms_path
        visit root_path
        click_link 'プライバシーポリシー'
        expect(current_path).to eq privacy_path
        visit root_path
        click_link '運営者情報'
        expect(current_path).to eq admin_path
      end
    end
  end
end
