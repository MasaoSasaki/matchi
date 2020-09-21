class AddIndex < ActiveRecord::Migration[5.2]

  def up
    add_index :menu_tags, [:menu_id, :tag_id]
    add_index :menus, :restaurant_id
    add_index :reservations, [:user_id, :menu_id]
  end

  def down
    remove_index :menu_tags, [:menu_id, :tag_id]
    remove_index :menus, :restaurant_id
    remove_index :reservations, [:user_id, :menu_id]
  end

end
