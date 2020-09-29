class Tag < ApplicationRecord

  has_many :menu_tags, dependent: :destroy

  validates :name, presence: true, uniqueness: true

end
