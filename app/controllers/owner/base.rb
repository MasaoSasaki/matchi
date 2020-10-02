class Owner::Base < ApplicationController

  # 管理者がログイン中は登録店舗全て閲覧可能
  before_action :authenticate_owner_restaurant!, unless: :master_admin_signed_in?

  # 閲覧しようとする店舗ページがログイン店舗のものかどうか？
  def current_restaurant?
    unless master_admin_signed_in?
      unless (params[:restaurant_id] || params[:id]) == current_owner_restaurant.id.to_s
        redirect_to owner_restaurant_path(current_owner_restaurant)
      end
    end
  end

  # 閲覧しようとするメニューページがログイン店舗のものかどうか？
  def current_menu?
    unless Menu.find_by(id: params[:id], restaurant_id: current_owner_restaurant.id)
      redirect_to owner_restaurant_menus_path(current_owner_restaurant)
    end
  end

  def set_current_restaurant
    @restaurant = current_owner_restaurant
  end

end
