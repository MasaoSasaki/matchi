class CreateUserReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :user_reviews do |t|
      t.references :user, foreign_key: true, null: false
      t.references :restaurant, foreign_key: true, null: false
      t.text :comment, default: ""

      t.timestamps
    end
  end
end
