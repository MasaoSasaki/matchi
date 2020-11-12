class AddDefault < ActiveRecord::Migration[5.2]

  def up
    change_column :menus, :menu_image_id, :string, default: ""
    change_column :restaurants, :restaurant_image_id, :string, default: ""
    change_column :restaurants, :corporate, :string, default: ""
    change_column :restaurants, :twitter, :string, default: ""
    change_column :restaurants, :facebook, :string, default: ""
    change_column :restaurants, :instagram, :string, default: ""
    change_column :restaurants, :building, :string, default: ""
  end

  def down
    change_column_default :menus, :menu_image_id, nil
    change_column_default :restaurants, :restaurant_image_id, nil
    change_column_default :restaurants, :corporate, nil
    change_column_default :restaurants, :twitter, nil
    change_column_default :restaurants, :facebook, nil
    change_column_default :restaurants, :instagram, nil
    change_column_default :restaurants, :building, nil
  end

end
