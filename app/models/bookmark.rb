class Bookmark < ApplicationRecord

  belongs_to :user
  belongs_to :restaurant

  # バリデーション
  with_options presence: true do
    validates :user_id
    validates :restaurant_id
  end
  with_options numericality: { only_integer: true } do
    validates :user_id
    validates :restaurant_id
  end

end
