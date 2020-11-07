class RemoveDefault < ActiveRecord::Migration[5.2]
  def up
    change_column_default :menu_reviews, :comment, nil
    change_column_default :restaurant_reviews, :comment, nil
    change_column_default :user_reviews, :comment, nil
    change_column :menu_reviews, :comment, :text, null: true
    change_column :restaurant_reviews, :comment, :text, null: true
    change_column :user_reviews, :comment, :text, null: true
  end
  def down
    change_column_default :menu_reviews, :comment, 1
    change_column_default :restaurant_reviews, :comment, 1
    change_column_default :user_reviews, :comment, 1
    change_column :menu_reviews, :comment, :text, null: false
    change_column :restaurant_reviews, :comment, :text, null: false
    change_column :user_reviews, :comment, :text, null: false
  end
end
