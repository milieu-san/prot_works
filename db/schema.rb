# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2019_09_23_081115) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "comments", force: :cascade do |t|
    t.text "body", null: false
    t.bigint "review_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_comments_on_review_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "genres", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "goods", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "review_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["review_id"], name: "index_goods_on_review_id"
    t.index ["user_id", "review_id"], name: "index_goods_on_user_id_and_review_id", unique: true
    t.index ["user_id"], name: "index_goods_on_user_id"
  end

  create_table "hearts", force: :cascade do |t|
    t.bigint "user_id", null: false
    t.bigint "prot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prot_id"], name: "index_hearts_on_prot_id"
    t.index ["user_id", "prot_id"], name: "index_hearts_on_user_id_and_prot_id", unique: true
    t.index ["user_id"], name: "index_hearts_on_user_id"
  end

  create_table "media_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "nodes", force: :cascade do |t|
    t.string "title", default: "new node", null: false
    t.text "body", default: "", null: false
    t.integer "position", null: false
    t.integer "parent_id"
    t.bigint "prot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prot_id"], name: "index_nodes_on_prot_id"
  end

  create_table "prot_genres", force: :cascade do |t|
    t.bigint "prot_id", null: false
    t.bigint "genre_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["genre_id"], name: "index_prot_genres_on_genre_id"
    t.index ["prot_id"], name: "index_prot_genres_on_prot_id"
  end

  create_table "prot_media_types", force: :cascade do |t|
    t.bigint "prot_id", null: false
    t.bigint "media_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["media_type_id"], name: "index_prot_media_types_on_media_type_id"
    t.index ["prot_id"], name: "index_prot_media_types_on_prot_id"
  end

  create_table "prots", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", default: "", null: false
    t.boolean "private", default: true, null: false
    t.boolean "accepts_review", default: true, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.index ["user_id"], name: "index_prots_on_user_id"
  end

  create_table "reviews", force: :cascade do |t|
    t.string "title", null: false
    t.text "content", null: false
    t.bigint "user_id", null: false
    t.bigint "prot_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["prot_id"], name: "index_reviews_on_prot_id"
    t.index ["user_id"], name: "index_reviews_on_user_id"
  end

  create_table "stars", force: :cascade do |t|
    t.integer "give_user_id", null: false
    t.integer "take_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["give_user_id", "take_user_id"], name: "index_stars_on_give_user_id_and_take_user_id", unique: true
    t.index ["give_user_id"], name: "index_stars_on_give_user_id"
    t.index ["take_user_id"], name: "index_stars_on_take_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name", null: false
    t.string "nick_name", null: false
    t.text "profile", default: "", null: false
    t.text "icon", default: ""
    t.string "provider"
    t.string "uid"
    t.string "username"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["provider", "uid"], name: "index_users_on_provider_and_uid", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "comments", "reviews"
  add_foreign_key "comments", "users"
  add_foreign_key "goods", "reviews"
  add_foreign_key "goods", "users"
  add_foreign_key "hearts", "prots"
  add_foreign_key "hearts", "users"
  add_foreign_key "prot_genres", "genres"
  add_foreign_key "prot_genres", "prots"
  add_foreign_key "prot_media_types", "media_types"
  add_foreign_key "prot_media_types", "prots"
  add_foreign_key "prots", "users"
  add_foreign_key "reviews", "prots"
  add_foreign_key "reviews", "users"
end
