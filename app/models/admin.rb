class Admin < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  # バリデーションチェック
  validates :email, format: { with: ADDRESS_REGEX }
  with_options length: { maximum: 255 } do
    validates :email
    validates :password
  end

end
