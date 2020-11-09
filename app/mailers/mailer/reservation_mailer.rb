class Mailer::ReservationMailer < ApplicationMailer

  # 予約者側
  def general_reservation_mail(reservation)
    mail to: reservation.user.email, subject: "ご予約を受け付けました。"
  end

  # 予約店舗側
  def restaurant_reservation_mail(reservation)
    mail to: reservation.menu.restaurant.email, subject: "ご予約がありました。"
  end

end
