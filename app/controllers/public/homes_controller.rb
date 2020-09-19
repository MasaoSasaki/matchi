class Public::HomesController < Public::Base

  def top
    @menus = Menu.all
    @restaurants = Restaurant.all
    gon.restaurants = Restaurant.all
  end

  def about

  end

  def contact

  end

  def privacy

  end

  def terms

  end

  def admin

  end

  def redirect
    @id = "#{params[:user_id]}" + "#{params[:restaurant_id]}"
  end

end
