class Owner::MenusController < Owner::Base

  # (jsでAPIキーを使わなくなったためコメントアウト)
  # before_action :api, only: %i[edit new create update]
  before_action :current_restaurant?, except: %i[get_vision_tags]
  before_action :current_menu?, except: %i[index new create get_vision_tags], unless: :master_admin_signed_in?
  before_action :set_current_restaurant, except: %i[destroy]
  before_action :set_restaurant, only: %i[index show new edit]
  # get_vision_tagsのPOSTアクションのみcsrf除外
  protect_from_forgery with: :null_session, only: %i[get_vision_tags]

  def index
    @menus = @restaurant.menus
  end

  def show
    @menu = Menu.find(params[:id])
    @menu_tags = MenuTag.where(menu_id: params[:id])
  end

  def new
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
    menu_new = Menu.new(menu_params)
    menu_new.restaurant_id = @current_restaurant.id
    if menu_new.save

      # 推奨タグが選択されているかどうか？
      unless params[:tag_id].nil?
        # 推奨タグの新規追加
        params[:tag_id].each do |tag, box|
          if box == "1"
            menu_tag = MenuTag.new
            menu_tag.menu_id = menu_new.id
            menu_tag.tag_id = tag.to_i
            menu_tag.save
          end
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
          new_menu_tag = MenuTag.new
          new_menu_tag.menu_id = menu_new.id
          new_menu_tag.tag_id = Tag.find_by(name: "#{tag}").id
          new_menu_tag.save
        end
      end
      redirect_to owner_restaurant_menu_path(@current_restaurant, menu_new)
    else
      render :new
    end
  end

  def update
    menu = Menu.find(params[:id])
    menu.reservation_method = params[:reservation_method].to_i

    # 現在のタグから削除されたタグの処理
    if params[:existing_tag]
      after_existing_tags = params[:existing_tag].map(&:to_i)
      before_existing_tags = menu.menu_tags.ids
      return if before_existing_tags == after_existing_tags
      before_existing_tags.each do |before_existing_tag|
        unless after_existing_tags.include?(before_existing_tag)
          MenuTag.find(before_existing_tag).destroy
        end
      end
    end

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
      redirect_to owner_restaurant_menu_path(@current_restaurant, menu)
    else
      render :edit
    end
  end

  def destroy
    menu = Menu.find(params[:id])
    menu.destroy
    redirect_to owner_restaurant_menus_path
  end

  def set_restaurant
    @restaurant = Restaurant.find(params[:restaurant_id])
  end

  def get_vision_tags
    image_file = params[:menu_image]
    tags = Gcp.post_vision_api(image_file)

    case params[:lang_data]
    # タグを取得する(英語)が押されたら
    when "pure"
      @tags_pure = tags

    # タグを取得する(日本語)が押されたら
    when "ja"
      @tags_ja = []
      tags.each do |tag|
        @tags_ja << Gcp.post_translation_api(tag)
      end

    # タグを取得する(日本語・英語)が押されたら
    when "all"
      @tags_pure = tags
      @tags_ja = []
      tags.each do |tag|
        @tags_ja << Gcp.post_translation_api(tag)
      end
    end
  end

  private
  def menu_params
    params.require(:menu).permit(
      :title, :menu_image, :content, :cancel, :regular_price,
      :discount_price, :reservation_method, :is_sale_frag
    )
  end

end
