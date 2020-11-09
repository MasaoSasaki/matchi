class Public::ReservationsController < Public::Base

  before_action :authenticate_user!

  def index
    @reservations = Reservation.where(user_id: current_user.id)
  end

  def show
    @reservation = Reservation.find(params[:id])
    @menu = @reservation.menu
    @restaurant = @reservation.menu.restaurant
    @user = @reservation.user
  end

  def new
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.new
  end

  def create
    @reservation = Reservation.new(reservation_params)
    @reservation.user_id = current_user.id
    @menu = @reservation.menu
    render :new and return if params[:back] || !@reservation.save
    # 最新の予約情報を取得
    new_reservation_id = Reservation.order(created_at: :desc).limit(1).ids
    redirect_to user_reservations_completion_path(new_reservation_id: new_reservation_id)
    Mailer::ReservationMailer.general_reservation_mail(@reservation).deliver
    Mailer::ReservationMailer.restaurant_reservation_mail(@reservation).deliver
  end

  def confirm
    @reservation = Reservation.new(reservation_params)
    @menu = @reservation.menu
  end

  def completion
  end

  private
  def reservation_params
    params.require(:reservation).permit(
      :menu_id, :people, :payment_method,
      :reservation_year, :reservation_month, :reservation_day, :reservation_time)
  end

end
