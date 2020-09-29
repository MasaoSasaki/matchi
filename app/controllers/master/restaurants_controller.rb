class Master::RestaurantsController < Master::Base

  def index
    @restaurants = Restaurant.all
    @menus = Menu.all
    @restaurant = Restaurant.new
  end

  def create
    @restaurants = Restaurant.all
    @menus = Menu.all
    @restaurant = Restaurant.new(restaurant_params)
    @restaurant.password = "000000"
    if @restaurant.save
      redirect_to master_path(current_master_admin)
    else
      render :index
    end
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:email)
  end

end
