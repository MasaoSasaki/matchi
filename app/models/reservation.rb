class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :menu

  enum payment_method: { cash: 0 }

  # バリデーション
  with_options presence: true do
    validates :reservation_month
    validates :reservation_day
    validates :reservation_time
  end
  with_options numericality: { only_integer: true } do
    validates :user_id
    validates :menu_id
    validates :reservation_year
    validates :people
    validates :reservation_status
  end
  with_options length: { maximum: 2 } do
    validates :reservation_month
    validates :reservation_day
    validates :reservation_time
  end

end
