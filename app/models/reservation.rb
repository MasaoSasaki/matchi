class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :menu

  enum payment_method: { cash: 0 }
  enum reservation_status: { advance: 0, complete: 1, cancel_1: 2, cancel_2: 3, before_cancel: 4, on_the_day_cancel: 5, serious: 6 }

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
  end
  with_options length: { maximum: 2 } do
    validates :reservation_month
    validates :reservation_day
    validates :reservation_time
  end

  # 予約日時の結合
  def reservation_date
    "#{ reservation_year } / #{ reservation_month } /  #{ reservation_day } / #{ reservation_time }"
  end

end
