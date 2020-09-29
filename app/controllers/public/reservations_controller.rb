class Public::ReservationsController < Public::Base

  before_action :authenticate_user!

  def index
    @reservations = Reservation.where(user_id: current_user.id)
    @menus = Menu.all
    @restaurants = Restaurant.all
  end

  def show
    @reservation = Reservation.find(params[:id])
    @menu = Menu.find(@reservation.menu_id)
    @restaurant = Restaurant.find(@menu.restaurant_id)
  end

  def new
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.new
  end

  def create
    reservation = Reservation.new(reservation_params)
    reservation.user_id = current_user.id
    reservation.save
    # 最新の予約情報を取得
    new_reservation_id = Reservation.order(created_at: :desc).limit(1).ids
    redirect_to user_reservations_completion_path(new_reservation_id: new_reservation_id)
  end

  def confirm
    @menu = Menu.find(params[:menu_id])
    @reservation = Reservation.new
  end

  def completion
    @new_reservation_id = params[:new_reservation_id]
  end

  private
  def reservation_params
    params.require(:reservation).permit(
      :menu_id, :people, :payment_method,
      :reservation_year, :reservation_month, :reservation_day, :reservation_time)
  end

end
