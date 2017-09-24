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

ActiveRecord::Schema.define(version: 20170924070626) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "ayahs", force: :cascade do |t|
    t.integer "number"
    t.integer "character_length"
    t.float "percent_of_total"
    t.float "percent_of_surah"
    t.bigint "surah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "favorites_count", default: 0
    t.integer "memories_count", default: 0
    t.index ["surah_id"], name: "index_ayahs_on_surah_id"
  end

  create_table "comments", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "topic_id"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["topic_id"], name: "index_comments_on_topic_id"
    t.index ["user_id"], name: "index_comments_on_user_id"
  end

  create_table "discussions", force: :cascade do |t|
    t.string "subject"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_discussions_on_user_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "ayah_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_favorites_on_ayah_id"
    t.index ["user_id", "ayah_id"], name: "index_favorites_on_user_id_and_ayah_id", unique: true
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "direction"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "likes", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_likes_on_ayah_id"
    t.index ["user_id", "ayah_id"], name: "index_likes_on_user_id_and_ayah_id", unique: true
    t.index ["user_id"], name: "index_likes_on_user_id"
  end

  create_table "memories", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_memories_on_ayah_id"
    t.index ["user_id", "ayah_id"], name: "index_memories_on_user_id_and_ayah_id", unique: true
    t.index ["user_id"], name: "index_memories_on_user_id"
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

  create_table "posts", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["user_id"], name: "index_posts_on_user_id"
  end

  create_table "qurans", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "language_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["language_id"], name: "index_qurans_on_language_id"
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["name"], name: "index_roles_on_name", unique: true
  end

  create_table "rolings", force: :cascade do |t|
    t.bigint "user_id"
    t.bigint "role_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["role_id"], name: "index_rolings_on_role_id"
    t.index ["user_id"], name: "index_rolings_on_user_id"
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
    t.bigint "quran_id"
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_texts_on_ayah_id"
    t.index ["quran_id"], name: "index_texts_on_quran_id"
  end

  create_table "topics", force: :cascade do |t|
    t.string "subject"
    t.text "content"
    t.string "discussable_type"
    t.bigint "discussable_id"
    t.bigint "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["discussable_type", "discussable_id"], name: "index_topics_on_discussable_type_and_discussable_id"
    t.index ["user_id"], name: "index_topics_on_user_id"
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
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["username"], name: "index_users_on_username", unique: true
  end

  add_foreign_key "ayahs", "surahs"
  add_foreign_key "comments", "topics"
  add_foreign_key "comments", "users"
  add_foreign_key "discussions", "users"
  add_foreign_key "favorites", "ayahs"
  add_foreign_key "favorites", "users"
  add_foreign_key "likes", "ayahs"
  add_foreign_key "likes", "users"
  add_foreign_key "memories", "ayahs"
  add_foreign_key "memories", "users"
  add_foreign_key "pages", "users"
  add_foreign_key "posts", "users"
  add_foreign_key "qurans", "languages"
  add_foreign_key "rolings", "roles"
  add_foreign_key "rolings", "users"
  add_foreign_key "shares", "ayahs"
  add_foreign_key "texts", "ayahs"
  add_foreign_key "texts", "qurans"
  add_foreign_key "topics", "users"
end
