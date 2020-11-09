require 'rails_helper'

RSpec.describe 'Tags', type: :system do
  before do
    admin = create(:admin)
    sign_in admin
  end
  describe 'indexページのテスト' do
    before do
      visit master_tags_path
    end
    it 'ページが表示される' do
      expect(page).to have_css '.master-tags-index'
    end
  end
end
