class AddNullFalse < ActiveRecord::Migration[5.2]

  def up
    change_column :contacts, :email, :string, null: false
    change_column :contacts, :message, :text, null: false
    change_column :menus, :restaurant_id, :integer, null: false
    change_column :menus, :title, :string, null: false
    change_column :reservations, :user_id, :integer, null: false
    change_column :reservations, :menu_id, :integer, null: false
  end

  def down
    change_column :contacts, :email, :string, null: true
    change_column :contacts, :message, :text, null: true
    change_column :menus, :restaurant_id, :integer, null: true
    change_column :menus, :title, :string, null: true
    change_column :reservations, :user_id, :integer, null: true
    change_column :reservations, :menu_id, :integer, null: true
  end

end
