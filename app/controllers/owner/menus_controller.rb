class Owner::MenusController < Owner::Base

  before_action :current_restaurant?
  before_action :api, only: [:edit, :new, :create, :update]

  def index
    @current_restaurant = current_owner_restaurant
    @menus = Menu.where(restaurant_id: params[:restaurant_id])
  end

  def show
    @menu = Menu.find(params[:id])
    @menu_tags = MenuTag.where(menu_id: params[:id])
  end

  def new
    @restaurant = Restaurant.find(params[:restaurant_id])
    @menu = Menu.new
    @menu_tags = MenuTag.where(menu_id: params[:id])
    @tags = Tag.all
  end

  def edit
    @menu = Menu.find(params[:id])
    @menu_tags = MenuTag.where(menu_id: params[:id])
    @tags = Tag.all
  end

  def create
    new_menu = Menu.new(menu_params)
    new_menu.restaurant_id = current_owner_restaurant.id
    if new_menu.save
      # 推奨タグの新規追加
      params[:tag_id].each do |tag, box|
        if box == "1"
          menu_tag = MenuTag.new
          menu_tag.menu_id = new_menu.id
          menu_tag.tag_id = tag.to_i
          menu_tag.save
        end
      end

      tags = Vision.get_image_data(new_menu.menu_image)
      tags.each do |tag|
        new_tag = Tag.new
        new_tag.name = tag
        new_tag.save
        new_menu_tag = MenuTag.new
        new_menu_tag.menu_id = new_menu.id
        new_menu_tag.tag_id = new_tag.id
        new_menu_tag.save
      end

      # フォームに値があるかどうか？
      unless params[:tag].nil?
        # Tagの新規追加
        params[:tag].each do |tag|
          unless Tag.find_by(name: "#{tag}")
            new_tag = Tag.new
            new_tag.name = "#{tag}"
            new_tag.save
          end
        end

        #MenuTagの新規追加
        params[:tag].each do |tag|
          new_menu_tag = MenuTag.new
          new_menu_tag.menu_id = new_menu.id
          new_menu_tag.tag_id = Tag.find_by(name: "#{tag}").id
          new_menu_tag.save
        end
      end

      redirect_to owner_restaurant_menu_path(current_owner_restaurant, new_menu)
    else
      render :edit
    end
  end

  def update
    restaurant = Restaurant.find(params[:restaurant_id])
    menu = Menu.find(params[:id])
    menu.reservation_method = params[:reservation_method].to_i
    if menu.update(menu_params)
      # 推奨タグの追加・削除
      params[:tag_id].each do |tag, box|
        # チェックマークが入っている時の処理（追加）
        if box == "1"
          if MenuTag.find_by(tag_id: tag.to_i, menu_id: menu.id).nil?
            menu_tag = MenuTag.new
            menu_tag.menu_id = menu.id
            menu_tag.tag_id = tag.to_i
            menu_tag.save
          end
        # チェックマークが入っていない時の処理（削除）
        elsif box == "0"
          remove_menu_tag = MenuTag.find_by(tag_id: tag.to_i, menu_id: menu.id)
          unless remove_menu_tag.nil?
            remove_menu_tag.destroy
          end
        end
      end

      tags = Vision.get_image_data(menu.menu_image)
      tags.each do |tag|
        unless Tag.find_by(name: tag)
          new_tag = Tag.new
          new_tag.name = tag
          new_tag.save
        end
        unless MenuTag.find_by(menu_id: menu.id, tag_id: Tag.find_by(name: tag).id)
          new_menu_tag = MenuTag.new
          new_menu_tag.menu_id = menu.id
          new_menu_tag.tag_id = Tag.find_by(name: tag).id
          new_menu_tag.save
        end
      end

      # フォームに値があるかどうか？
      unless params[:tag].nil?
        # Tagの新規追加
        params[:tag].each do |tag|
          unless Tag.find_by(name: "#{tag}")
            new_tag = Tag.new
            new_tag.name = "#{tag}"
            new_tag.save
          end
        end

        #MenuTagの新規追加
        params[:tag].each do |tag|
          unless MenuTag.find_by(menu_id: menu.id, tag_id: Tag.find_by(name: "#{tag}").id)
            new_menu_tag = MenuTag.new
            new_menu_tag.menu_id = menu.id
            new_menu_tag.tag_id = Tag.find_by(name: "#{tag}").id
            new_menu_tag.save
          end
        end
      end
      redirect_to owner_restaurant_menu_path(current_owner_restaurant, menu)
    else
      render :edit
    end
  end

  def destroy
    menu = Menu.find(params[:id])
    menu.destroy
    redirect_to owner_restaurant_menus_path
  end

  private
  def menu_params
    params.require(:menu).permit(
      :title, :menu_image, :content, :cancel, :regular_price,
      :discount_price, :reservation_method, :is_sale_frag
    )
  end

end
