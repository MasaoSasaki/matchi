class Owner::RestaurantsController < Owner::Base
  def show
    @restaurant = Restaurant.find(params[:id])
    current_menu = Menu.where(restaurant_id: params[:id])
    @reservations_count = Reservation.where(menu_id: current_menu).count
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    restaurant = Restaurant.find(params[:id])
    restaurant.update(restaurant_params)
    redirect_to owner_restaurant_path(restaurant)
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(
      :name, :restaurant_image, :introduction, :postal_code, :address, :phone_number,
      :corpolate, :twitter, :facebook, :instagram, :completion_message
    )
  end

end
