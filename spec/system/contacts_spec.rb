require 'rails_helper'

RSpec.describe 'Contacts', type: :system do
  describe 'newページのテスト' do
    before do
      visit new_contact_path
    end
    it 'ページが表示される' do
      expect(page).to have_css '.contacts-new'
    end
    describe 'confirmページのテスト' do
      before do
        fill_in 'contact[email]', with: 'test@test.com'
        fill_in 'contact[message]', with: 'RSpecテストメール'
        click_button '確認する'
      end
      it 'ページが表示される' do
        expect(current_path).to eq confirm_contact_path
        expect(page).to have_css '.contacts-confirm'
      end
      describe 'conmpletionページのテスト' do
        it 'ページが表示される' do
          click_button '送信'
          expect(current_path).to eq completion_contact_path
          expect(page).to have_css '.contacts-completion'
        end
      end
    end
  end
end