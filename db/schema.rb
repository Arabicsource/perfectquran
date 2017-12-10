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

ActiveRecord::Schema.define(version: 20171210223654) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visibility", default: 0
    t.string "permalink"
    t.integer "collection", default: 0
    t.bigint "category_id"
    t.bigint "user_id"
    t.integer "comments_count", default: 0
    t.index ["category_id"], name: "index_articles_on_category_id"
    t.index ["user_id"], name: "index_articles_on_user_id"
  end

  create_table "ayahs", force: :cascade do |t|
    t.integer "number"
    t.integer "character_length"
    t.float "percent_of_total"
    t.float "percent_of_surah"
    t.bigint "surah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["surah_id"], name: "index_ayahs_on_surah_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "user_id"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["article_id"], name: "index_comments_on_article_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "facebook_shares", force: :cascade do |t|
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_facebook_shares_on_ayah_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "direction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "menu_links", force: :cascade do |t|
    t.string "name"
    t.string "path"
    t.bigint "menu_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["menu_id"], name: "index_menu_links_on_menu_id"
  end

  create_table "menus", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "pages", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "permalink"
    t.index ["permalink"], name: "index_pages_on_permalink", unique: true
    t.index ["user_id"], name: "index_pages_on_user_id"
  end

  create_table "shares", force: :cascade do |t|
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_shares_on_ayah_id"
  end

  create_table "surahs", force: :cascade do |t|
    t.integer "number_of_ayahs"
    t.integer "order_of_revelation"
    t.integer "revelation_type"
    t.string "permalink"
    t.string "transliterated_name"
    t.string "arabic_name"
    t.string "english_name"
    t.integer "character_length"
    t.float "percent_of_total"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "texts", force: :cascade do |t|
    t.text "content"
    t.bigint "translation_id"
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_texts_on_ayah_id"
    t.index ["translation_id"], name: "index_texts_on_translation_id"
  end

  create_table "translations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_translations_on_language_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "sign_in_count", default: 0, null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet "current_sign_in_ip"
    t.inet "last_sign_in_ip"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "name"
    t.string "username"
    t.string "bio"
    t.string "role", default: "validating"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "articles", "categories"
  add_foreign_key "articles", "users"
  add_foreign_key "ayahs", "surahs"
  add_foreign_key "comments", "articles"
  add_foreign_key "comments", "users"
  add_foreign_key "facebook_shares", "ayahs"
  add_foreign_key "menu_links", "menus"
  add_foreign_key "pages", "users"
  add_foreign_key "shares", "ayahs"
  add_foreign_key "texts", "ayahs"
  add_foreign_key "texts", "translations"
  add_foreign_key "translations", "languages"
end
