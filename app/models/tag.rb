class Tag < ApplicationRecord

  has_many :menu_tags, dependent: :destroy

end
