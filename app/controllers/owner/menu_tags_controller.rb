class Owner::MenuTagsController < Owner::Base

  before_action :set_current_restaurant, only: %i[destroy]

  def create
    new_menu_tag = MenuTag.new
    menu_id = params[:menu_id]
    restaurant_id = params[:restaurant_id]
    @tag_id = params[:tag_id]
    new_menu_tag.tag_id = @tag_id
    new_menu_tag.menu_id = @@menu_id
    new_menu_tag.save
    redirect_to edit_owner_restaurant_menu_path(restaurant_id, menu_id)
  end

  def destroy
    menu_tag = MenuTag.find(params[:id])
    menu_tag.destroy
    redirect_to edit_owner_restaurant_menu_path(@restaurant, menu_tag.menu)
  end

end
