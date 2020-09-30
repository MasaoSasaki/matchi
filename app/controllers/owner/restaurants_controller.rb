class Owner::RestaurantsController < Owner::Base

  before_action :current_restaurant?, only: %i[show]
  before_action :api, only: %i[edit]

  def show
    @restaurant = Restaurant.find(params[:id])
    current_menu = Menu.where(restaurant_id: params[:id])
    @reservations_count = Reservation.where(menu_id: current_menu).count
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    @restaurant = Restaurant.find(params[:id])
    if @restaurant.update(restaurant_params)
      redirect_to owner_restaurant_path(@restaurant)
    else
      render :edit
    end
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(
      :name, :restaurant_image, :introduction,
      :postal_code, :prefecture, :city, :street, :building,
      :phone_number, :email, :corpolate,
      :twitter, :facebook, :instagram, :completion_message
    )
  end

end
