require 'rails_helper'

RSpec.describe 'Homes', type: :system do
  describe 'aboutページのテスト' do
    before do
      visit about_path
    end
    it 'ページが表示される' do
      expect(page).to have_css '.public-homes-about'
    end
    it '1つリンクにアクセスできる' do
      click_link 'TOPへ'
      expect(current_path).to eq root_path
    end
  end
  describe 'adminページのテスト' do
    before do
      visit admin_path
    end
    it 'ページが表示される' do
      expect(page).to have_css '.public-homes-admin'
    end
    it '1つにリンクにアクセスできる' do
      click_link 'https://matchi-gourmet.com/'
      expect(current_path).to eq root_path
    end
  end
  describe 'privacyページのテスト' do
    before do
      visit privacy_path
    end
    it 'ページが表示される' do
      expect(page).to have_css '.public-homes-privacy'
    end
    it '1つのリンクにアクセスできる' do
      find('.public-homes-privacy--new_contact_path').click
      expect(current_path).to eq new_contact_path
    end
  end
  describe 'termsページのテスト' do
    it 'ページが表示される' do
      visit terms_path
      expect(page).to have_css '.public-homes-terms'
    end
  end
  describe 'topページのテスト' do
    before do
      visit root_path
    end
    describe 'ログイン状態共通' do
      describe 'メインコンテンツのテスト' do
        before do
          @menu = create(:menu)
          @restaurant = @menu.restaurant
          visit root_path
        end
        it 'ページが表示される' do
          expect(page).to have_css '.public-homes-top'
        end
        it 'ヘッダー画像下3つのリンクにアクセスできる' do
          within('.top-nav') do
            click_link 'サービス紹介'
            expect(current_path).to eq about_path
            visit root_path
            click_link 'メニュー一覧'
            expect(current_path).to eq menus_path
            visit root_path
            click_on 'レストラン一覧'
            expect(current_path).to eq restaurants_path
          end
        end
        it 'レストランにアクセスできる' do
          within('.public-homes-top__body__main__restaurants-all') do
            click_link @restaurant.name
            expect(current_path).to eq restaurant_path(@restaurant)
            visit root_path
            find('.restaurant-image0').click
            expect(current_path).to eq restaurant_path(@restaurant)
            visit root_path
            click_link 'レストラン一覧'
            expect(current_path).to eq restaurants_path
          end
        end
        it 'メニューにアクセスできる' do
          within('.public-homes-top__body__main__menus-all') do
            click_link @menu.title
            expect(current_path).to eq menu_path(@menu)
            visit root_path
            find('.menu-image0').click
            expect(current_path).to eq menu_path(@menu)
            visit root_path
            click_link 'メニュー一覧'
            expect(current_path).to eq menus_path
          end
        end
      end
      describe 'サイドバーのテスト' do
        before do
          @menu = create(:menu)
          visit root_path
        end
        it '最近更新されたメニューにサクセスできる' do
          within('.new-menus-list') do
            find('.side-bar--menu0-title').click
            expect(current_path).to eq menu_path(@menu)
            visit root_path
            find('.side-bar--menu0-image').click
            expect(current_path).to eq menu_path(@menu)
          end
        end
      end
    end
    describe '未ログインの場合' do
      describe 'メインコンテンツのテスト' do
        it 'ヘッダー画像上に3つのボタンが表示' do
          within('.public-homes-top__header-image__contents') do
            click_link '新規登録'
            expect(current_path).to eq new_user_registration_path
            visit root_path
            click_link 'ログイン'
            expect(current_path).to eq new_user_session_path
            visit root_path
            click_link 'サービス紹介'
            expect(current_path).to eq about_path
          end
        end
      end
      describe 'サイドバーのテスト' do
        it '新規登録・ログインが表示' do
          within('.public-homes-top__body__side') do
            click_link '新規登録'
            expect(current_path).to eq new_user_registration_path
            visit root_path
            click_link 'こちら'
            expect(current_path).to eq new_user_session_path
          end
        end
        it 'マイページが非表示' do
          within('.public-homes-top__body__side') do
            expect(page).to_not have_content 'マイページ'
          end
        end
      end
    end
    describe 'ログイン済みの場合' do
      before do
        @user = create(:user)
        visit new_user_session_path
        fill_in 'user[email]', with: @user.email
        fill_in 'user[password]', with: @user.password
        click_button 'ログイン'
      end
      describe 'メインコンテンツのテスト' do
        it 'ヘッダー画像上の3つのボタンが非表示' do
          within('.public-homes-top__header-image__contents') do
            expect(page).to_not have_content '新規登録'
            expect(page).to_not have_content 'ログイン'
            expect(page).to_not have_content 'サービス紹介'
          end
        end
      end
      describe 'サイドバーのテスト' do
        it 'マイページが表示' do
          within('.public-homes-top__body__side') do
            expect(page).to have_content 'マイページ'
          end
        end
        it '新規登録・ログインが非表示' do
          within('.public-homes-top__body__side') do
            expect(page).to_not have_content '新規登録'
            expect(page).to_not have_content 'こちら'
          end
        end
      end
    end
  end
end
