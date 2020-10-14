class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations

  attachment :profile_image

  enum user_status: {member: 0, withdrew: 1, forced: 2}

  with_options presence: true do
    validates :name_family
    validates :name_first
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

  with_options numericality: { only_integer: true } do
    validates :birth_year
    validates :birth_month
    validates :birth_day
    validates :user_status
  end

  validates :phone_number, length: { maximum: 15 }
  MAIL_ADDRESS_REGEX = /\A[\w+\-.]+@[a-z\d\-.]+\.[a-z]+\z/i
  NAME_KANA_REGEX = /\A[ぁ-んァ-ヶー－]+\z/ # 全角かな・カナのみ
  with_options format: { with: MAIL_ADDRESS_REGEX } do
    validates :email
    validates :email_sub
  end
  with_options format: { with: NAME_KANA_REGEX } do
    validates :name_family_kana
    validates :name_first_kana
  end

  # ログイン時、有効会員(member)かどうか？
  def active_for_authentication?
    super && (self.user_status == "member")
  end

end
