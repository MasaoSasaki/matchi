class CreateMenuReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_reviews do |t|
      t.references :menu, foreign_key: true, null: false
      t.references :user, foreign_key: true, null: false
      t.text :comment

      t.timestamps
    end
  end
end
