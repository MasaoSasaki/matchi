require 'rails_helper'

RSpec.describe User, type: :model do

  describe 'Userモデルのテスト' do
    context '保存ができる場合のテスト' do
      it '保存できる' do
        expect(FactoryBot.build(:user)).to be_valid
      end
      it ':email_subが空白の場合も保存できる' do
        user = build(:user, email_sub: nil)
        expect(user).to be_valid
      end
    end
    context '保存ができない場合のテスト' do
      it ':emailが空白の場合は保存できない' do
        user = build(:user, email: nil)
        user.valid?
        expect(user.errors[:email][0]).to include("入力してください")
      end
      it ':emailが255文字を超える場合は保存できない' do
        user = build(:user, email: 'a@a.a' + ('a' * 255))
        user.valid?
        expect(user.errors[:email][0]).to include("255文字以内で入力してください")
      end
      it ':emailに@がなければ保存できない' do
        user = build(:user, email: 'aa.a')
        user.valid?
        expect(user.errors[:email][0]).to include("不正な値です")
      end
      it ':emailに.がなければ保存できない' do
        user = build(:user, email: 'a@a')
        user.valid?
        expect(user.errors[:email][0]).to include("不正な値です")
      end
      it ':emailの値が重複する場合は保存できない' do
        user = build(:user, email: create(:user).email)
        user.valid?
        expect(user.errors[:email][0]).to include("すでに存在します")
      end
      it ':passwordが空白の場合は保存できない' do
        user = build(:user, password: nil)
        user.valid?
        expect(user.errors[:password][0]).to include("入力してください")
      end
      it ':passwordが128文字を超える場合は保存できない' do
        user = build(:user, password: '0' * 129)
        user.valid?
        expect(user.errors[:password][0]).to include("128文字以内で入力してください")
      end
      it ':passwordが6文字未満の場合は保存できない' do
        user = build(:user, password: '0' * 5)
        user.valid?
        expect(user.errors[:password][0]).to include("6文字以上で入力してください")
      end
      it ':name_familyが空白の場合は保存できない' do
        user = build(:user, name_family: nil)
        user.valid?
        expect(user.errors[:name_family][0]).to include("入力してください")
      end
      it ':name_familyが255文字を超える場合は保存できない' do
        user = build(:user, name_family: 'a' * 256)
        user.valid?
        expect(user.errors[:name_family][0]).to include("255文字以内で入力してください")
      end
      it ':name_firstが空白の場合は保存できない' do
        user = build(:user, name_first: nil)
        user.valid?
        expect(user.errors[:name_first][0]).to include("入力してください")
      end
      it ':name_firstが255文字を超える場合は保存できない' do
        user = build(:user, name_first: 'a' * 256)
        user.valid?
        expect(user.errors[:name_first][0]).to include("255文字以内で入力してください")
      end
      it ':name_family_kanaが空白の場合は保存できない' do
        user = build(:user, name_family_kana: nil)
        user.valid?
        expect(user.errors[:name_family_kana][0]).to include("入力してください")
      end
      it ':name_family_kanaが255文字を超える場合は保存できない' do
        user = build(:user, name_family_kana: 'a' * 256)
        user.valid?
        expect(user.errors[:name_family_kana][0]).to include("255文字以内で入力してください")
      end
      it ':name_family_kanaが漢字の場合は保存できない' do
        user = build(:user, name_family_kana: '田中' )
        user.valid?
        expect(user.errors[:name_family_kana][0]).to include("不正な値です")
      end
      it ':name_first_kanaが空白の場合は保存できない' do
        user = build(:user, name_first_kana: nil)
        user.valid?
        expect(user.errors[:name_first_kana][0]).to include("入力してください")
      end
      it ':name_first_kanaが255文字を超える場合は保存できない' do
        user = build(:user, name_first_kana: 'a' * 256)
        user.valid?
        expect(user.errors[:name_first_kana][0]).to include("255文字以内で入力してください")
      end
      it ':name_first_kanaが漢字の場合は保存できない' do
        user = build(:user, name_first_kana: '太郎' )
        user.valid?
        expect(user.errors[:name_first_kana][0]).to include("不正な値です")
      end
      it ':profile_image_idが255文字を超える場合は保存できない' do
        user = build(:user, profile_image_id: 'a' * 256)
        user.valid?
        expect(user.errors[:profile_image_id][0]).to include("255文字以内で入力してください")
      end
      it ':twitterが255文字を超える場合は保存できない' do
        user = build(:user, twitter: 'a' * 256)
        user.valid?
        expect(user.errors[:twitter][0]).to include("255文字以内で入力してください")
      end
      it ':facebookが255文字を超える場合は保存できない' do
        user = build(:user, facebook: 'a' * 256)
        user.valid?
        expect(user.errors[:facebook][0]).to include("255文字以内で入力してください")
      end
      it ':instagramが255文字を超える場合は保存できない' do
        user = build(:user, instagram: 'a' * 256)
        user.valid?
        expect(user.errors[:instagram][0]).to include("255文字以内で入力してください")
      end
      it ':phone_numberが15文字を超える場合は保存できない' do
        user = build(:user, phone_number: '0' * 16)
        user.valid?
        expect(user.errors[:phone_number][0]).to include("15文字以内で入力してください")
      end
      it '誕生日が文字列型の場合は保存できない' do
        user = build(:user, birth_year: '１９００')
        user.valid?
        expect(user.errors[:birth_year][0]).to include("数値で入力してください")
        user = build(:user, birth_month: '１')
        user.valid?
        expect(user.errors[:birth_month][0]).to include("数値で入力してください")
        user = build(:user, birth_day: '１')
        user.valid?
        expect(user.errors[:birth_day][0]).to include("数値で入力してください")
      end

    end
  end

end
