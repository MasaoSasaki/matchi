class Reservation < ApplicationRecord

  belongs_to :user
  belongs_to :menu

  enum payment_method: { cash: 0 }

end
