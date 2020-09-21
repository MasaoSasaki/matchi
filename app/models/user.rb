class User < ApplicationRecord

  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable

  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :reservations

  enum user_status: [:"有効会員", :"退会済み", :"強制退会"]

  attachment :profile_image

  validates :name_family, presence: true
  validates :name_first, presence: true
  validates :name_family_kana, presence: true
  validates :name_first_kana, presence: true
  validates :phone_number, presence: true

  def active_for_authentication?
    super && (self.user_status == "有効会員")
  end

end
