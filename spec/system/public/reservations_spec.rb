require 'rails_helper'

RSpec.describe 'Reservations', type: :system do
  before do
    @reservation = create(:reservation)
    @user = @reservation.user
    @menu = @reservation.menu
    @restaurant = @menu.restaurant
    sign_in @user
  end
  describe 'indexページのテスト' do
    before do
      visit user_reservations_path(@user)
    end
    it 'ページが表示される' do
      expect(current_path).to eq user_reservations_path(@user)
    end
    it '3つのリンクにアクセスできる' do
      find('.reservation0--show_path').click
      expect(current_path).to eq user_reservation_path(@user, @reservation)
      visit user_reservations_path(@user)
      find('.reservation0--restaurant-name').click
      expect(current_path).to eq restaurant_path(@restaurant)
      visit user_reservations_path(@user)
      find('.reservation0--menu-title').click
      expect(current_path).to eq menu_path(@menu)
    end
  end
  describe 'showページのテスト' do
    before do
      visit user_reservation_path(@user, @reservation)
    end
    it 'ページが表示される' do
      expect(current_path).to eq user_reservation_path(@user, @reservation)
    end
    it '3つのリンクにアクセスできる' do
      click_link @restaurant.name
      expect(current_path).to eq restaurant_path(@restaurant)
      visit user_reservation_path(@user, @reservation)
      click_link @menu.title
      expect(current_path).to eq menu_path(@menu)
      visit user_reservation_path(@user, @reservation)
      click_link 'マイページへ戻る'
      expect(current_path).to eq user_mypage_path
    end
  end
  describe 'newページのテスト' do
    before do
      visit new_user_reservation_path(@user, menu_id: @menu)
    end
    it 'ページが表示される' do
      expect(current_path).to eq new_user_reservation_path(@user)
    end
    it '2つのリンクにアクセスできる' do
      click_link 'メニュー詳細へ戻る'
      expect(current_path).to eq menu_path(@menu)
      visit new_user_reservation_path(@user, menu_id: @menu)
      click_link 'メニュー一覧へ'
      expect(current_path).to eq menus_path
    end
    it '確認画面へ進める' do
      fill_in 'reservation[people]', with: @reservation.people
      select '店舗でお支払い', from: 'お支払い方法'
      fill_in 'reservation[reservation_year]', with: @reservation.reservation_year
      fill_in 'reservation[reservation_month]', with: @reservation.reservation_month
      fill_in 'reservation[reservation_day]', with: @reservation.reservation_day
      fill_in 'reservation[reservation_time]', with: @reservation.reservation_time
      click_button '確認する'
      expect(page).to have_content '予約情報の確認'
    end
  end
  describe 'confirmページのテスト' do
    before do
      visit new_user_reservation_path(@user, menu_id: @menu)
      fill_in 'reservation[people]', with: @reservation.people
      select '店舗でお支払い', from: 'お支払い方法'
      fill_in 'reservation[reservation_year]', with: @reservation.reservation_year
      fill_in 'reservation[reservation_month]', with: @reservation.reservation_month
      fill_in 'reservation[reservation_day]', with: @reservation.reservation_day
      fill_in 'reservation[reservation_time]', with: @reservation.reservation_time
      click_button '確認する'
      expect(page).to have_content '予約情報の確認'
    end
    it '"修正する"ボタンで前のページに遷移' do
      click_button '修正する'
      expect(page).to have_content '予約情報の入力'
      expect(page).to have_field '人数', with: @reservation.people
      expect(page).to have_select('お支払い方法', selected: @reservation.payment_method_i18n)
      expect(page).to have_field '日時', with: @reservation.reservation_time
    end
    it '"予約を確定する"ボタンでcompletionに遷移' do
      click_button '予約を確定する'
      expect(current_path).to eq user_reservations_completion_path(@user)
    end
  end
  describe 'completionページのテスト' do
    before do
      visit user_reservations_completion_path(@user)
    end
    it 'ページが表示される' do
      expect(current_path).to eq user_reservations_completion_path(@user)
    end
    context 'confirmページからの遷移の場合' do
      it '予約完了メッセージが表示される' do
        visit user_reservations_completion_path(@user, new_reservation_id: @reservation)
        expect(page).to have_content 'ご予約が確定しました！'
      end
      it '1つのリンクにアクセスできる' do
        visit user_reservations_completion_path(@user, new_reservation_id: @reservation)
        click_link '店舗からのメッセージをご確認ください。'
        expect(current_path).to eq user_reservation_path(@user, @reservation)
      end
    end
    context '直接アクセスされた場合' do
      it '確定済みメッセージが表示される' do
        expect(page).to have_content 'ご予約は確定済みです！'
      end
      it '1つのリンクにアクセスできる' do
        click_link '予約一覧'
        expect(current_path).to eq user_reservations_path(@user)
      end
    end
  end
end
