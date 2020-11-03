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
    @restaurant.password = SecureRandom.alphanumeric(6)
    if @restaurant.save
      flash.now[:success] = "店舗を登録しました。初期パスワードは#{ @restaurant.password }です。"
      render :index
    else
      @restaurants = Restaurant.all
      @menus = Menu.all
      render :index
    end
  end

  private
  def restaurant_params
    params.require(:restaurant).permit(:email)
  end

end
