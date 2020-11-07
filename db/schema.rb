# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# Note that this schema.rb definition is the authoritative source for your
# database schema. If you need to create the application database on another
# system, you should be using db:schema:load, not running all the migrations
# from scratch. The latter is a flawed and unsustainable approach (the more migrations
# you'll amass, the slower it'll run and the greater likelihood for issues).
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_11_07_132023) do

  create_table "admins", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_admins_on_email", unique: true
    t.index ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true
  end

  create_table "bookmarks", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "restaurant_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_bookmarks_on_restaurant_id"
    t.index ["user_id"], name: "index_bookmarks_on_user_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "email", null: false
    t.text "message", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_reviews", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "user_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_reviews_on_menu_id"
    t.index ["user_id"], name: "index_menu_reviews_on_user_id"
  end

  create_table "menu_tags", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id", "tag_id"], name: "index_menu_tags_on_menu_id_and_tag_id"
  end

  create_table "menus", force: :cascade do |t|
    t.integer "restaurant_id", null: false
    t.string "title", null: false
    t.string "menu_image_id", default: ""
    t.text "content", default: ""
    t.text "cancel", default: ""
    t.integer "regular_price", null: false
    t.integer "discount_price", null: false
    t.integer "reservation_method", default: 0, null: false
    t.boolean "is_sale_frag", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "menu_id", null: false
    t.integer "reservation_year", null: false
    t.string "reservation_month", null: false
    t.string "reservation_day", null: false
    t.string "reservation_time", null: false
    t.integer "people", null: false
    t.integer "reservation_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_method", default: 0
    t.index ["user_id", "menu_id"], name: "index_reservations_on_user_id_and_menu_id"
  end

  create_table "restaurant_reviews", force: :cascade do |t|
    t.integer "restaurant_id", null: false
    t.integer "user_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_restaurant_reviews_on_restaurant_id"
    t.index ["user_id"], name: "index_restaurant_reviews_on_user_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", default: "", null: false
    t.string "restaurant_image_id", default: ""
    t.text "introduction", default: ""
    t.string "postal_code", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "corporate", default: ""
    t.string "twitter", default: ""
    t.string "facebook", default: ""
    t.string "instagram", default: ""
    t.text "completion_message", default: ""
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefecture"
    t.string "city"
    t.string "street"
    t.string "building", default: ""
    t.index ["email"], name: "index_restaurants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_restaurants_on_reset_password_token", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_tags_on_name", unique: true
  end

  create_table "user_reviews", force: :cascade do |t|
    t.integer "user_id", null: false
    t.integer "restaurant_id", null: false
    t.text "comment"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_user_reviews_on_restaurant_id"
    t.index ["user_id"], name: "index_user_reviews_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name_family", null: false
    t.string "name_first", null: false
    t.string "name_family_kana", null: false
    t.string "name_first_kana", null: false
    t.string "handle_name", default: ""
    t.text "profile", default: ""
    t.string "profile_image_id", default: ""
    t.string "twitter", default: ""
    t.string "facebook", default: ""
    t.string "instagram", default: ""
    t.string "phone_number", null: false
    t.string "email_sub", default: ""
    t.integer "birth_year", default: 1900
    t.integer "birth_month", default: 1
    t.integer "birth_day", default: 1
    t.integer "user_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
