class Contact < ApplicationRecord

  with_options presence: { message: '必須項目です。' } do
    validates :email
    validates :message
  end

  validates :email, format: { with: ADDRESS_REGEX, message: 'メールアドレスが正しくありません。' }, length: { maximum:255 }

end
