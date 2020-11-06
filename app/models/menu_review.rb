class MenuReview < ApplicationRecord
  belongs_to :user

  with_options numericality: { only_integer: true } do
    validates :menu_id
    validates :user_id
  end
end
