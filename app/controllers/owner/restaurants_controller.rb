class Owner::RestaurantsController < Owner::Base

  before_action :current_restaurant?, only: %i[show]
  before_action :set_current_restaurant
  before_action :api, only: %i[edit]

  def show
    @restaurant = Restaurant.find(params[:id])
    @menus = @restaurant.menus
    @reservations = Reservation.where(menu_id: @menus).count
  end

  def edit
    @restaurant = Restaurant.find(params[:id])
  end

  def update
    if @current_restaurant.update(restaurant_params)
      redirect_to owner_restaurant_path(@current_restaurant)
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
