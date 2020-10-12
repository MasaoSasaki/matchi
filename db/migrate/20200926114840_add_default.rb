class AddDefault < ActiveRecord::Migration[5.2]

  def up
    change_column :users, :handle_name, :string, default: ""
    change_column :users, :profile_image_id, :string, default: ""
    change_column :users, :twitter, :string, default: ""
    change_column :users, :facebook, :string, default: ""
    change_column :users, :instagram, :string, default: ""
    change_column :users, :email_sub, :string, default: ""
    change_column :users, :birth_year, :integer, default: 1900
    change_column :users, :birth_month, :integer, default: 1
    change_column :users, :birth_day, :integer, default: 1
    change_column :menus, :menu_image_id, :string, default: ""
    change_column :restaurants, :restaurant_image_id, :string, default: ""
    change_column :restaurants, :corporate, :string, default: ""
    change_column :restaurants, :twitter, :string, default: ""
    change_column :restaurants, :facebook, :string, default: ""
    change_column :restaurants, :instagram, :string, default: ""
    change_column :restaurants, :building, :string, default: ""
  end

  def down
    change_column_default :users, :handle_name, nil
    change_column_default :users, :profile_image_id, nil
    change_column_default :users, :twitter, nil
    change_column_default :users, :facebook, nil
    change_column_default :users, :instagram, nil
    change_column_default :users, :email_sub, nil
    change_column_default :users, :birth_year, nil
    change_column_default :users, :birth_month, nil
    change_column_default :users, :birth_day, nil
    change_column_default :menus, :menu_image_id, nil
    change_column_default :restaurants, :restaurant_image_id, nil
    change_column_default :restaurants, :corporate, nil
    change_column_default :restaurants, :twitter, nil
    change_column_default :restaurants, :facebook, nil
    change_column_default :restaurants, :instagram, nil
    change_column_default :restaurants, :building, nil
  end

end
