class Restaurant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations
  has_many :menus, dependent: :destroy

  attachment :restaurant_image

  include JpPrefecture
  jp_prefecture :prefecture, method_name: :pref

  # バリデーションチェック

  with_options on: :update? do
    validates :email, presence: true
    validates :name, presence: true
    validates :postal_code, presence: true
    validates :phone_number, presence: true
  end

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_id).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_id = JpPrefecture::Prefecture.find(name: prefecture).code
  end

end
