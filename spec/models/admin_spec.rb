require 'rails_helper'

RSpec.describe Admin, type: :model do

  describe 'adminモデルのテスト' do
    context '保存ができる場合のテスト' do
      it '保存できる' do
        admin = build(:admin)
        expect(admin).to be_valid
      end
    end
    context '保存ができない場合のテスト' do
      it ':emailが空白の場合は保存できない' do
        admin = build(:admin, email: nil)
        expect(admin).to be_invalid
      end
      it ':emailが255文字を超える場合は保存できない' do
        admin = build(:admin, email: 'a@a.a' + ('a' * 255))
        expect(admin).to be_invalid
      end
      it ':emailに@がなければ保存できない' do
        admin = build(:admin, email: 'aa.a')
        expect(admin).to be_invalid
      end
      it ':emailに.がなければ保存できない' do
        admin = build(:admin, email: 'a@a')
        expect(admin).to be_invalid
      end
      it ':emailの値が重複する場合は保存できない' do
        admin = build(:admin)
        admin.save
        duplicate_admin = build(:admin, email: admin.email)
        expect(duplicate_admin).to be_invalid
      end
      it ':passwordが空白の場合は保存できない' do
        admin = build(:admin, password: nil)
        expect(admin).to be_invalid
      end
      it ':passwordが255文字を超える場合は保存できない' do
        admin = build(:admin, password: '0' * 256)
        expect(admin).to be_invalid
      end
      it ':passwordが6文字未満の場合は保存できない' do
        admin = build(:admin, password: '0' * 5)
        expect(admin).to be_invalid
      end
    end
  end

end
