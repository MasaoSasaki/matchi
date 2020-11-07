class CreateRestaurantReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :restaurant_reviews do |t|
      t.references :restaurant, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.text :comment, default: ""

      t.timestamps
    end
  end
end
