class Owner::MenusController < Owner::Base
  def index
    @menus = Menu.where(restaurant_id: params[:restaurant_id])
  end

  def show
    @menu = Menu.find(params[:id])
  end

  def edit
    @menu = Menu.find(params[:id])
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.new
  end

  def create
    menu_new = Menu.new(menu_params)
    menu_new.restaurant_id = current_owner_restaurant.id
    menu_new.save
    redirect_to owner_restaurant_menu_path(current_owner_restaurant, menu_new)
  end

  def update
    restaurant = Restaurant.find(params[:restaurant_id])
    menu = Menu.find(params[:id])
  end

  def destroy
    menu = Menu.find(params[:id])
    menu.destroy
    redirect_to owner_restaurant_menus_path
  end

  private
  def menu_params
    params.require(:menu).permit(
      :title, :menu_imeg, :content, :cancel, :regular_plice,
      :discount_plice, :reservation_method, :is_sale_frag
    )
  end

end
