require 'rails_helper'

RSpec.describe 'Menus', type: :system do
  before do
    @menu = create(:menu)
  end
  describe 'indexページのテスト' do
    before do
      visit menus_path
    end
    it 'メニューにアクセスできる' do
      expect(current_path).to eq menus_path
      find('.menu0--title').click
      expect(current_path).to eq menu_path(@menu)
      visit menus_path
      find('.menu0--image').click
      expect(current_path).to eq menu_path(@menu)
    end
  end
  describe 'showページのテスト' do
    before do
      visit menu_path(@menu)
    end
    describe 'リンクのテスト' do
      it '2つのリンクにアクセスできる' do
        expect(current_path).to eq menu_path(@menu)
        within('.public-menus-show') do
          click_link 'メニュー一覧'
          expect(current_path).to eq menus_path
          visit menu_path(@menu)
          click_link 'TOP'
          expect(current_path).to eq root_path
        end
      end
    end
    describe '予約ボタンのテスト' do
      context '未ログインの場合' do
        it '予約ボタンが非アクティブ' do
          expect(page).to have_no_link '予約情報を入力する'
        end
        it '2つのリンクにアクセスできる' do
          within('.reservation') do
            click_link '新規ご登録'
            expect(current_path).to eq new_user_registration_path
            visit menu_path(@menu)
            click_link 'ログイン'
            expect(current_path).to eq new_user_session_path
          end
        end
      end
      context 'ログイン済みの場合' do
        before do
          @user = create(:user)
          visit new_user_session_path
          fill_in 'user[email]', with: @user.email
          fill_in 'user[password]', with: @user.password
          click_button 'ログイン'
          visit menu_path(@menu)
        end
        context 'メニューが"予約のみ"、または"予約可能"の場合' do
          it 'ボタンがアクティブ' do
            click_button '予約情報を入力する'
            expect(current_path).to eq new_user_reservation_path(@user)
          end
        end
        context 'メニューが"予約不可"の場合' do
          it '予約ボタンが非アクティブ' do
            click_button '予約情報を入力する'
            expect(page).to have_no_link '予約情報を入力する'
          end
        end
      end
    end
  end
end
