class Menu < ApplicationRecord

  belongs_to :restaurant
  has_many :reservations
  has_many :menu_tags, dependent: :destroy

  enum reservation_method: { simply: 0, done: 1, not: 2 }

  attachment :menu_image

  with_options presence: true do
    validates :title
  end

  with_options length: { maximum: 255 } do
    validates :title
    validates :menu_image_id
  end

  with_options numericality: { only_integer: true } do
    validates :restaurant_id
    validates :regular_price
    validates :discount_price
  end

  validates :is_sale_frag, inclusion: { in: [true, false] }

end
