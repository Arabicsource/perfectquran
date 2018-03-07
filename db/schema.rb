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

ActiveRecord::Schema.define(version: 2018_03_07_110347) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "account_email_preferences", force: :cascade do |t|
    t.bigint "account_id"
    t.boolean "general", default: true
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.boolean "daily_ayah", default: false
    t.index ["account_id"], name: "index_account_email_preferences_on_account_id"
  end

  create_table "accounts", force: :cascade do |t|
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
    t.string "role", default: "validating"
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
  end

  create_table "active_storage_attachments", force: :cascade do |t|
    t.string "name", null: false
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.bigint "blob_id", null: false
    t.datetime "created_at", null: false
    t.index ["blob_id"], name: "index_active_storage_attachments_on_blob_id"
    t.index ["record_type", "record_id", "name", "blob_id"], name: "index_active_storage_attachments_uniqueness", unique: true
  end

  create_table "active_storage_blobs", force: :cascade do |t|
    t.string "key", null: false
    t.string "filename", null: false
    t.string "content_type"
    t.text "metadata"
    t.bigint "byte_size", null: false
    t.string "checksum", null: false
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "articles", force: :cascade do |t|
    t.string "title"
    t.text "content"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "visibility", default: 0
    t.string "permalink"
    t.integer "collection", default: 0
    t.bigint "category_id"
    t.bigint "account_id"
    t.integer "comments_count", default: 0
    t.index ["account_id"], name: "index_articles_on_account_id"
    t.index ["category_id"], name: "index_articles_on_category_id"
  end

  create_table "ayahs", force: :cascade do |t|
    t.integer "number"
    t.integer "character_length"
    t.bigint "surah_id"
    t.bigint "page_id"
    t.index ["page_id"], name: "index_ayahs_on_page_id"
    t.index ["surah_id"], name: "index_ayahs_on_surah_id"
  end

  create_table "bookmarks", force: :cascade do |t|
    t.string "bookmarkable_type"
    t.bigint "bookmarkable_id"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_bookmarks_on_account_id"
    t.index ["bookmarkable_type", "bookmarkable_id"], name: "index_bookmarks_on_bookmarkable_type_and_bookmarkable_id"
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "charges", force: :cascade do |t|
    t.bigint "account_id"
    t.integer "amount_in_cents"
    t.string "payment_brand"
    t.string "payment_last4"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_charges_on_account_id"
  end

  create_table "comments", force: :cascade do |t|
    t.text "content"
    t.bigint "account_id"
    t.bigint "article_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_comments_on_account_id"
    t.index ["article_id"], name: "index_comments_on_article_id"
  end

  create_table "connections", force: :cascade do |t|
    t.string "name"
    t.string "provider"
    t.string "provider_uid"
    t.string "token"
    t.string "secret"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "last_ayah_id", default: 0
    t.boolean "active", default: false
    t.bigint "translation_id"
    t.string "hashtags"
    t.index ["account_id"], name: "index_connections_on_account_id"
    t.index ["provider_uid", "provider"], name: "index_connections_on_provider_uid_and_provider", unique: true
    t.index ["translation_id"], name: "index_connections_on_translation_id"
  end

  create_table "daily_ayahs", force: :cascade do |t|
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_daily_ayahs_on_ayah_id"
  end

  create_table "facebook_shares", force: :cascade do |t|
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_facebook_shares_on_ayah_id"
  end

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string "slug", null: false
    t.integer "sluggable_id", null: false
    t.string "sluggable_type", limit: 50
    t.string "scope"
    t.datetime "created_at"
    t.index ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true
    t.index ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type"
    t.index ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id"
    t.index ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type"
  end

  create_table "juzs", force: :cascade do |t|
    t.integer "character_length"
  end

  create_table "languages", force: :cascade do |t|
    t.string "name"
    t.string "direction"
  end

  create_table "memories", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_memories_on_account_id"
    t.index ["ayah_id"], name: "index_memories_on_ayah_id"
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
    t.integer "character_length"
    t.bigint "juz_id"
    t.index ["juz_id"], name: "index_pages_on_juz_id"
  end

  create_table "profiles", force: :cascade do |t|
    t.string "name"
    t.string "username"
    t.text "bio"
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_profiles_on_account_id"
  end

  create_table "shares", force: :cascade do |t|
    t.bigint "ayah_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["ayah_id"], name: "index_shares_on_ayah_id"
  end

  create_table "subscriptions", force: :cascade do |t|
    t.bigint "account_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "customer_token"
    t.string "subscription_token"
    t.string "status"
    t.string "payment_brand"
    t.string "payment_last4"
    t.string "current_period_end"
    t.index ["account_id"], name: "index_subscriptions_on_account_id"
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
  end

  create_table "taggings", force: :cascade do |t|
    t.bigint "account_id"
    t.bigint "tag_id"
    t.string "taggable_type"
    t.bigint "taggable_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_taggings_on_account_id"
    t.index ["tag_id"], name: "index_taggings_on_tag_id"
    t.index ["taggable_type", "taggable_id"], name: "index_taggings_on_taggable_type_and_taggable_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "texts", force: :cascade do |t|
    t.text "content"
    t.bigint "translation_id"
    t.bigint "ayah_id"
    t.index ["ayah_id"], name: "index_texts_on_ayah_id"
    t.index ["translation_id"], name: "index_texts_on_translation_id"
  end

  create_table "translations", force: :cascade do |t|
    t.string "name"
    t.string "description"
    t.bigint "language_id"
    t.index ["language_id"], name: "index_translations_on_language_id"
  end

  add_foreign_key "account_email_preferences", "accounts"
  add_foreign_key "articles", "accounts"
  add_foreign_key "articles", "categories"
  add_foreign_key "ayahs", "pages"
  add_foreign_key "ayahs", "surahs"
  add_foreign_key "bookmarks", "accounts"
  add_foreign_key "charges", "accounts"
  add_foreign_key "comments", "accounts"
  add_foreign_key "comments", "articles"
  add_foreign_key "connections", "accounts"
  add_foreign_key "connections", "translations"
  add_foreign_key "daily_ayahs", "ayahs"
  add_foreign_key "facebook_shares", "ayahs"
  add_foreign_key "memories", "accounts"
  add_foreign_key "memories", "ayahs"
  add_foreign_key "menu_links", "menus"
  add_foreign_key "pages", "juzs"
  add_foreign_key "profiles", "accounts"
  add_foreign_key "shares", "ayahs"
  add_foreign_key "subscriptions", "accounts"
  add_foreign_key "taggings", "accounts"
  add_foreign_key "taggings", "tags"
  add_foreign_key "texts", "ayahs"
  add_foreign_key "texts", "translations"
  add_foreign_key "translations", "languages"
end
