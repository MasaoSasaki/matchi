class Public::HomesController < Public::Base
  def top
    @menus = Menu.all
    @restaurants = Restaurant.all
  end

  def about
  end
end