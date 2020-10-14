require 'rails_helper'

RSpec.describe Tag, type: :model do

  describe 'Tagモデルのテスト' do
    context '保存ができる場合のテスト' do
      it ':nameがあり、かつ一意性があれば保存できる' do
        tag = build(:tag)
        expect(tag).to be_valid
      end
    end
    context '保村ができない場合のテスト' do
      it ':nameが空白の場合は保存できない' do
        tag = build(:tag, name: nil)
        expect(tag).to be_invalid
      end
      it ':nameが255文字を超える場合は保存できない' do
        tag = build(:tag, name: '0' * 256)
        expect(tag).to be_invalid
      end
      it ':nameが重複する場合は保存できない' do
        tag = build(:tag)
        tag.save
        duplicate_tag = build(:tag, name: tag.name)
        expect(duplicate_tag).to be_invalid
      end
    end
  end

end
