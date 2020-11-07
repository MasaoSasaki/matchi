class RestaurantReview < ApplicationRecord
  has_many :user_review

  with_options numericality: { only_integer: true } do
    validates :restaurant_id
    validates :user_id
  end
end
