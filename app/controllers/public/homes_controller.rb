class Public::HomesController < Public::Base

  def top
    @menus = Menu.all.order(id: 'DESC')
    @restaurants = Restaurant.all.order(id: 'DESC')
    gon.restaurants = Restaurant.all
  end

  def about
  end

  def privacy
  end

  def terms
  end

  def admin
  end

  def redirect
  end

end
