class UserReview < ApplicationRecord
  belongs_to :restaurant

  with_options numericality: { only_integer: true } do
    validates :user_id
    validates :restaurant_id
  end
end
