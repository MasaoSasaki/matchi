class Public::MenusController < Public::Base

  before_action :exist_public_menu?, only: %i[show]

  def index
    if params[:restaurant_id]
      @menus = Menu.where(restaurant_id: params[:restaurant_id])
    else
       @menus = Menu.all
    end
    @restaurants = Restaurant.all
  end

  def show
    @menu = Menu.find(params[:id])
    restaurant_id = Menu.find(params[:id]).restaurant_id
    @restaurant = Restaurant.find(restaurant_id)
    @reservation = Reservation.new
  end

end
