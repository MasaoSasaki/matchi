require 'rails_helper'

RSpec.describe Contact, type: :model do

  describe 'Contactモデルのテスト' do
    context '保存ができる場合のテスト' do
      it '保存できる' do
        contact = build(:contact)
        expect(contact).to be_valid
      end
    end
    context '保存ができない場合のテスト' do
      it ':emailに@がなければ保存できない' do
        contact = build(:contact, email: 'aa.a')
        expect(contact).to be_invalid
      end
      it ':emailに.がなければ保存できない' do
        contact = build(:contact, email: 'a@a')
        expect(contact).to be_invalid
      end
      it ':emailの値が空白の場合は保存できない' do
        contact = build(:contact, email: nil)
        expect(contact).to be_invalid
      end
      it ':messageの値が空白の場合は保存できない' do
        contact = build(:contact, message: nil)
        expect(contact).to be_invalid
      end
    end
  end

end
