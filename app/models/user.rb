class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :confirmable

  has_many :reservations
  has_many :restaurant_reviews, dependent: :destroy
  has_many :menu_reviews, dependent: :destroy
  has_many :user_reviews, dependent: :destroy

  attachment :profile_image

  enum user_status: { member: 0, withdrew: 1, forced: 2, guest: 3 }

  with_options presence: true, unless: :guest_user? do
    validates :name_family
    validates :name_first
    validates :name_family_kana
    validates :name_first_kana
    validates :phone_number
  end
  with_options length: { maximum: 255 } do
    validates :email
    validates :password
    validates :name_family
    validates :name_first
    validates :name_family_kana
    validates :name_first_kana
    validates :handle_name
    validates :profile_image_id
    validates :twitter
    validates :facebook
    validates :instagram
    validates :email_sub
  end
  with_options numericality: { only_integer: true, allow_blank: true } do
    validates :birth_year
    validates :birth_month
    validates :birth_day
  end
  validates :phone_number, length: { maximum: 15 }
  NAME_KANA_REGEX = /\A[ぁ-んァ-ヶー－]+\z/ # 全角かな・カナのみ
  with_options format: { with: ADDRESS_REGEX } do
    validates :email
    validates :email_sub, on: :update?
  end
  with_options format: { with: NAME_KANA_REGEX }, unless: :guest_user? do
    validates :name_family_kana
    validates :name_first_kana
  end

  # ログイン時、有効会員(member)かどうか？
  def active_for_authentication?
    super && (self.user_status == "member" || self.user_status == "guest")
  end

  # 名前を結合
  def name
    if user_status == "guest"
      handle_name
    else
      name_family + name_first
    end
  end

  def name_kana
    name_family_kana + name_first_kana
  end

  # ゲスト会員
  def guest_user?
    user_status == "guest"
  end

end
