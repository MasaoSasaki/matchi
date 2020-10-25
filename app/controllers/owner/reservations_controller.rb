class Owner::ReservationsController < Owner::Base

  before_action :current_restaurant?, except: [:index]
  before_action :set_current_restaurant

  def index
    @reservations = Reservation.where(menu_id: Menu.where(restaurant_id: @current_restaurant))
  end

  def show
    @reservation = Reservation.find(params[:id])
  end

  def update
    reservation = Reservation.find(params[:id])
    if reservation.update(reservation_params)
      redirect_to owner_reservations_path
    else
      @reservation = reservation
      render :show
    end
  end

  private
  def reservation_params
    params.require(:reservation).permit(:reservation_status)
  end
end
