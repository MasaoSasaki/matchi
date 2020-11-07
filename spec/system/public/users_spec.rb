require 'rails_helper'

RSpec.describe 'Users', type: :system do
  describe 'users直下ページのテスト' do
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
    describe '_linksのテスト' do
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
  describe 'devise配下ページのテスト' do
    describe 'registrationsテスト' do
      describe 'newページのテスト' do
        before do
          visit new_user_registration_path
        end
        it 'ページが表示される' do
          expect(current_path).to eq new_user_registration_path
        end
        it '確認画面へ遷移できる' do
          within('.registration-form-sp') do
            fill_in 'user[name_family]', with: '田中'
            fill_in 'user[name_first]', with: '太郎'
            fill_in 'user[name_family_kana]', with: 'たなか'
            fill_in 'user[name_first_kana]', with: 'たろう'
            fill_in 'user[phone_number]', with: '00000000000'
            fill_in 'user[email]', with: 'taro@taro.com'
            fill_in 'user[password]', with: '000000'
            fill_in 'user[password_confirmation]', with: '000000'
          end
          all('.btn-success')[1].click
          expect(current_path).to eq users_sign_up_confirm_path
          visit new_user_registration_path
          within('.registration-form-pc') do
            fill_in 'user[name_family]', with: '田中'
            fill_in 'user[name_first]', with: '太郎'
            fill_in 'user[name_family_kana]', with: 'たなか'
            fill_in 'user[name_first_kana]', with: 'たろう'
            fill_in 'user[phone_number]', with: '00000000000'
            fill_in 'user[email]', with: 'taro@taro.com'
            fill_in 'user[password]', with: '000000'
            fill_in 'user[password_confirmation]', with: '000000'
          end
          all('.btn-success')[2].click
          expect(current_path).to eq users_sign_up_confirm_path
        end
        describe 'confirmページ(sp)のテスト' do
          before do
            within('.registration-form-sp') do
              fill_in 'user[name_family]', with: '田中'
              fill_in 'user[name_first]', with: '太郎'
              fill_in 'user[name_family_kana]', with: 'たなか'
              fill_in 'user[name_first_kana]', with: 'たろう'
              fill_in 'user[phone_number]', with: '00000000000'
              fill_in 'user[email]', with: 'taro@taro.com'
              fill_in 'user[password]', with: '000000'
              fill_in 'user[password_confirmation]', with: '000000'
            end
            all('.btn-success')[1].click
          end
          describe 'ボタンのテスト' do
            context '"修正する"ボタンの場合' do
              it 'newページに遷移する' do
                all('.btn-outline-dark')[0].click
                expect(page).to have_content '新規会員登録'
              end
            end
            context '"登録する"ボタンの場合' do
              it 'completeページに遷移する' do
                all('.btn-primary')[1].click
                expect(current_path).to eq users_sign_up_complete_path
              end
            end
          end
        end
        describe 'confirmページ(pc)のテスト' do
          before do
            within('.registration-form-pc') do
              fill_in 'user[name_family]', with: '田中'
              fill_in 'user[name_first]', with: '太郎'
              fill_in 'user[name_family_kana]', with: 'たなか'
              fill_in 'user[name_first_kana]', with: 'たろう'
              fill_in 'user[phone_number]', with: '00000000000'
              fill_in 'user[email]', with: 'taro@taro.com'
              fill_in 'user[password]', with: '000000'
              fill_in 'user[password_confirmation]', with: '000000'
            end
            all('.btn-success')[2].click
          end
          describe 'ボタンのテスト' do
            context '"修正する"ボタンの場合' do
              it 'newページに遷移する' do
                all('.btn-outline-dark')[1].click
                expect(page).to have_content '新規会員登録'
              end
            end
            context '"登録する"ボタンの場合' do
              it 'completeページに遷移する' do
                all('.btn-primary')[2].click
                expect(current_path).to eq users_sign_up_complete_path
              end
            end
          end
        end
      end
    end
    describe 'sessionsのテスト' do
      before do
        @user = create(:user)
        visit new_user_session_path
      end
      describe 'newページのテスト' do
        it 'ページが表示される' do
          expect(current_path).to eq new_user_session_path
        end
        it 'ログインに成功する' do
          fill_in 'user[email]', with: @user.email
          fill_in 'user[password]', with: @user.password
          click_button 'ログイン'
          expect(current_path).to eq root_path
        end
      end
    end
    describe 'sharedのテスト' do
      describe '_linksのテスト' do
        it '2つのリンクにアクセスできる' do
          visit new_user_registration_path
          all('.login-path')[0].click
          expect(current_path).to eq new_user_session_path
          visit new_user_registration_path
          all('.root-path')[0].click
          expect(current_path).to eq root_path
          visit new_user_registration_path
          all('.login-path')[1].click
          expect(current_path).to eq new_user_session_path
          visit new_user_registration_path
          all('.root-path')[1].click
          expect(current_path).to eq root_path
        end
      end
    end
  end
end
