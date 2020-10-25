require 'rails_helper'

RSpec.describe 'Homes' do
  describe 'aboutページのテスト' do
    it 'サービス紹介が表示される' do
      visit about_path
      expect(page).to have_content 'About'
    end
  end
  describe 'adminページのテスト' do
    it '運営者情報が表示される' do
      visit admin_path
      expect(page).to have_content '運営者情報'
    end
  end
  describe 'contactページのテスト' do
    it '問い合わせが表示される' do
      visit new_contact_path
      expect(page).to have_content 'お問い合わせ'
    end
  end
  describe 'privacyページのテスト' do
    it 'プライバシーポリシーが表示される' do
      visit privacy_path
      expect(page).to have_content 'プライバシーポリシー'
    end
  end
  describe 'termsページのテスト' do
    it '利用規約が表示される' do
      visit terms_path
      expect(page).to have_content '利用規約'
    end
  end
  describe 'topページのテスト' do
    it 'トップページが表示される' do
      visit root_path
      expect(page).to have_content 'Connect With Trust'
    end
  end
end
