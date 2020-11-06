class CreateMenuReviews < ActiveRecord::Migration[5.2]
  def change
    create_table :menu_reviews do |t|
      t.references :menu, foreign_key: true
      t.references :user, foreign_key: true
      t.text :comment, null: false

      t.timestamps
    end
  end
end
