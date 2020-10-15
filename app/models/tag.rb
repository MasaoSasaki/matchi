class Tag < ApplicationRecord

  has_many :menu_tags, dependent: :destroy

  validates :name, presence: true, uniqueness: true, length: { maximum: 255 }

end
