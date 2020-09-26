class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservation

  attachment :profile_image

  enum user_status: {member: 0, withdrew: 1, forced: 2}

  with_options presence: true do
    validates :name_family
    validates :name_first
    validates :name_family_kana
    validates :name_first_kana
    validates :phone_number
  end

  # ログイン時、有効会員(member)かどうか？
  def active_for_authentication?
    super && (self.user_status == "member")
  end

end
