require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Userモデルのテスト' do
    context '保存ができる場合のテスト' do
      it '保存できる' do
        user = build(:user)
        expect(user).to be_valid
      end
    end
    context '保存ができない場合のテスト' do
      it ':emailが空白の場合は保存できない' do
        user = build(:user, email: nil)
        expect(user).to be_invalid
      end
      it ':emailが255文字を超える場合は保存できない' do
        user = build(:user, email: 'a@a.a' + ('a' * 255))
        expect(user).to be_invalid
      end
      it ':emailに@がなければ保存できない' do
        user = build(:user, email: 'aa.a')
        expect(user).to be_invalid
      end
      it ':emailに.がなければ保存できない' do
        user = build(:user, email: 'a@a')
        expect(user).to be_invalid
      end
      it ':emailの値が重複する場合は保存できない' do
        user = build(:user)
        user.save
        duplicate_user = build(:user, email: user.email)
        expect(duplicate_user).to be_invalid
      end
      it ':passwordが空白の場合は保存できない' do
        user = build(:user, password: nil)
        expect(user).to be_invalid
      end
      it ':passwordが255文字を超える場合は保存できない' do
        user = build(:user, password: '0' * 256)
        expect(user).to be_invalid
      end
      it ':passwordが6文字未満の場合は保存できない' do
        user = build(:user, password: '0' * 5)
        expect(user).to be_invalid
      end
      it ':name_familyが空白の場合は保存できない' do
        user = build(:user, name_family: nil)
        expect(user).to be_invalid
      end
      it ':name_familyが255文字を超える場合は保存できない' do
        user = build(:user, name_family: 'a' * 256)
        expect(user).to be_invalid
      end
      it ':name_firstが空白の場合は保存できない' do
        user = build(:user, name_first: nil)
        expect(user).to be_invalid
      end
      it ':name_firstが255文字を超える場合は保存できない' do
        user = build(:user, name_first: 'a' * 256)
        expect(user).to be_invalid
      end
      it ':name_family_kanaが空白の場合は保存できない' do
        user = build(:user, name_family_kana: nil)
        expect(user).to be_invalid
      end
      it ':name_family_kanaが255文字を超える場合は保存できない' do
        user = build(:user, name_family_kana: 'a' * 256)
        expect(user).to be_invalid
      end
      it ':name_family_kanaが漢字の場合は保存できない' do
        user = build(:user, name_family_kana: '田中' )
        expect(user).to be_invalid
      end
      it ':name_first_kanaが空白の場合は保存できない' do
        user = build(:user, name_first_kana: nil)
        expect(user).to be_invalid
      end
      it ':name_first_kanaが255文字を超える場合は保存できない' do
        user = build(:user, name_first_kana: 'a' * 256)
        expect(user).to be_invalid
      end
      it ':name_first_kanaが漢字の場合は保存できない' do
        user = build(:user, name_first_kana: '太郎' )
        expect(user).to be_invalid
      end
      it ':profile_image_idが255文字を超える場合は保存できない' do
        user = build(:user, profile_image_id: 'a' * 256)
        expect(user).to be_invalid
      end
      it ':twitterが255文字を超える場合は保存できない' do
        user = build(:user, twitter: 'a' * 256)
        expect(user).to be_invalid
      end
      it ':facebookが255文字を超える場合は保存できない' do
        user = build(:user, facebook: 'a' * 256)
        expect(user).to be_invalid
      end
      it ':instagramが255文字を超える場合は保存できない' do
        user = build(:user, instagram: 'a' * 256)
        expect(user).to be_invalid
      end
      it ':phone_numberが15文字を超える場合は保存できない' do
        user = build(:user, phone_number: '0' * 16)
        expect(user).to be_invalid
      end
      it ':email_subが空白の場合は保存できない' do
        user = build(:user, email_sub: nil)
        expect(user).to be_invalid
      end
      it ':email_subが255文字を超える場合は保存できない' do
        user = build(:user, email_sub: 'a@a.a' + ('a' * 255))
        expect(user).to be_invalid
      end
      it ':email_subに@がなければ保存できない' do
        user = build(:user, email_sub: 'aa.a')
        expect(user).to be_invalid
      end
      it ':email_subに.がなければ保存できない' do
        user = build(:user, email_sub: 'a@a')
        expect(user).to be_invalid
      end
      it ':email_subの値が重複する場合は保存できない' do
        user = build(:user)
        user.save
        duplicate_user = build(:user, email_sub: user.email_sub)
        expect(duplicate_user).to be_invalid
      end
      it '誕生日が文字列型の場合は保存できない' do
        user = build(:user, birth_year: '１９００')
        expect(user).to be_invalid
        user = build(:user, birth_month: '１')
        expect(user).to be_invalid
        user = build(:user, birth_day: '１')
        expect(user).to be_invalid
      end

    end
  end

end
