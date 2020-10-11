require 'rails_helper'

RSpec.describe Tag, type: :model do

  describe 'バリデーションのテスト' do
    context ':name' do
      it ':nameに値があり、かつ一意性があれば保存できる' do
        tag = build(:tag)
        expect(tag).to be_valid
      end
      it ':nameの値が空白の場合は保存できない' do
        tag = build(:tag, name: nil)
        expect(tag).to be_invalid
      end
      it ':nameの値が重複する場合は保存できない' do
        tag = build(:tag)
        tag.save
        duplicate_tag = Tag.new(name: tag.name)
        expect(duplicate_tag).to be_invalid
      end
    end
  end
  
end
