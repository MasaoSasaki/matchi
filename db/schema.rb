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

ActiveRecord::Schema.define(version: 2020_09_21_080340) do

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
    t.string "email"
    t.text "message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_tags", force: :cascade do |t|
    t.integer "menu_id", null: false
    t.integer "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id", "tag_id"], name: "index_menu_tags_on_menu_id_and_tag_id"
  end

  create_table "menus", force: :cascade do |t|
    t.integer "restaurant_id"
    t.string "title"
    t.string "menu_image_id"
    t.text "content"
    t.text "cancel"
    t.integer "regular_price"
    t.integer "discount_price"
    t.integer "reservation_method", default: 0
    t.boolean "is_sale_frag", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["restaurant_id"], name: "index_menus_on_restaurant_id"
  end

  create_table "reservations", force: :cascade do |t|
    t.integer "user_id"
    t.integer "menu_id"
    t.integer "reservation_year"
    t.string "reservation_month"
    t.string "reservation_day"
    t.string "reservation_time"
    t.integer "people"
    t.integer "reservation_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "payment_method", default: 0
    t.index ["user_id", "menu_id"], name: "index_reservations_on_user_id_and_menu_id"
  end

  create_table "restaurants", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "name", default: "", null: false
    t.string "restaurant_image_id"
    t.text "introduction"
    t.string "postal_code", default: "", null: false
    t.string "phone_number", default: "", null: false
    t.string "corporate"
    t.string "twitter"
    t.string "facebook"
    t.string "instagram"
    t.text "completion_message"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "prefecture"
    t.string "city"
    t.string "street"
    t.string "building"
    t.index ["email"], name: "index_restaurants_on_email", unique: true
    t.index ["reset_password_token"], name: "index_restaurants_on_reset_password_token", unique: true
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
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
    t.string "handle_name"
    t.text "profile"
    t.string "profile_image_id"
    t.string "twitter"
    t.string "facebook"
    t.string "instagram"
    t.string "phone_number", null: false
    t.string "email_sub"
    t.integer "birth_year"
    t.integer "birth_month"
    t.integer "birth_day"
    t.integer "user_status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
