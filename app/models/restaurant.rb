class Restaurant < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable

  has_many :menus, dependent: :destroy
  has_many :bookmarks, dependent: :destroy

  attachment :restaurant_image

  include JpPrefecture
  jp_prefecture :prefecture, method_name: :pref

  # バリデーションチェック
  with_options on: :update do
    validates :name, presence: true
    validates :postal_code, presence: true
    validates :phone_number, presence: true
    validates :prefecture, presence: true
    validates :city, presence: true
    validates :street, presence: true
  end
  with_options length: { maximum: 255 } do
    validates :email
    validates :password
    validates :name
    validates :restaurant_image_id
    validates :corporate
    validates :twitter
    validates :facebook
    validates :instagram
    validates :prefecture
    validates :city
    validates :street
    validates :building
  end
  validates :postal_code, length: { maximum: 9 }
  validates :phone_number, length: { maximum: 15 }
  with_options format: { with: ADDRESS_REGEX } do
    validates :email
    # コーポレートサイトは空白、もしくは正規表現でのみ保存可能
    validates :corporate, unless: :presense_empty?
  end

  def prefecture_name
    JpPrefecture::Prefecture.find(code: prefecture_id).try(:name)
  end

  def prefecture_name=(prefecture_name)
    self.prefecture_id = JpPrefecture::Prefecture.find(name: prefecture).code
  end

  def address
    prefecture + city + street + building
  end


  private
  def presense_empty?
    corporate == ""
  end

end
