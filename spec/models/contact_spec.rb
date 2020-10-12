require 'rails_helper'

RSpec.describe Contact, type: :model do

  describe 'バリデーションのテスト' do
    context ':contactが保存できる' do
      it ':emailに@がなければ保存できない' do
        contact = build(:contact, email: 'aa')
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
