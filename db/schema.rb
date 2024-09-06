# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2024_09_06_005058) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "username", null: false
    t.date "dob", null: false
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.boolean "admin", default: false
    t.boolean "mod", default: false
    t.string "bio"
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "followers_count", default: 0, null: false
    t.integer "following_count", default: 0, null: false
    t.index ["email"], name: "index_accounts_on_email", unique: true
    t.index ["reset_password_token"], name: "index_accounts_on_reset_password_token", unique: true
    t.index ["username"], name: "index_accounts_on_username", unique: true
  end

  create_table "action_text_rich_texts", force: :cascade do |t|
    t.string "name", null: false
    t.text "body"
    t.string "record_type", null: false
    t.bigint "record_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["record_type", "record_id", "name"], name: "index_action_text_rich_texts_uniqueness", unique: true
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
    t.string "service_name", null: false
    t.bigint "byte_size", null: false
    t.string "checksum"
    t.datetime "created_at", null: false
    t.index ["key"], name: "index_active_storage_blobs_on_key", unique: true
  end

  create_table "active_storage_variant_records", force: :cascade do |t|
    t.bigint "blob_id", null: false
    t.string "variation_digest", null: false
    t.index ["blob_id", "variation_digest"], name: "index_active_storage_variant_records_uniqueness", unique: true
  end

  create_table "categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "episode_tags", force: :cascade do |t|
    t.bigint "episode_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_episode_tags_on_episode_id"
    t.index ["tag_id"], name: "index_episode_tags_on_tag_id"
  end

  create_table "episodes", force: :cascade do |t|
    t.string "title", null: false
    t.bigint "podcast_id", null: false
    t.bigint "category_id", null: false
    t.integer "likes_count", default: 0, null: false
    t.integer "saves_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["category_id"], name: "index_episodes_on_category_id"
    t.index ["podcast_id"], name: "index_episodes_on_podcast_id"
  end

  create_table "follows", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "followable_type", null: false
    t.bigint "followable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "followable_id", "followable_type"], name: "idx_on_account_id_followable_id_followable_type_b71b2f7ef2", unique: true
    t.index ["account_id", "followable_id"], name: "index_follows_on_account_id_and_followable_id", unique: true
    t.index ["account_id"], name: "index_follows_on_account_id"
    t.index ["followable_type", "followable_id"], name: "index_follows_on_followable"
  end

  create_table "podcast_tags", force: :cascade do |t|
    t.bigint "podcast_id", null: false
    t.bigint "tag_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["podcast_id"], name: "index_podcast_tags_on_podcast_id"
    t.index ["tag_id"], name: "index_podcast_tags_on_tag_id"
  end

  create_table "podcasts", force: :cascade do |t|
    t.string "name", null: false
    t.integer "episodes_count", default: 0, null: false
    t.integer "followers_count", default: 0, null: false
    t.bigint "account_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_podcasts_on_account_id"
    t.index ["category_id"], name: "index_podcasts_on_category_id"
  end

  create_table "relationships", force: :cascade do |t|
    t.integer "follower_id"
    t.integer "followed_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["followed_id"], name: "index_relationships_on_followed_id"
    t.index ["follower_id", "followed_id"], name: "index_relationships_on_follower_id_and_followed_id", unique: true
    t.index ["follower_id"], name: "index_relationships_on_follower_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "episode_tags", "episodes"
  add_foreign_key "episode_tags", "tags"
  add_foreign_key "episodes", "categories"
  add_foreign_key "episodes", "podcasts"
  add_foreign_key "follows", "accounts"
  add_foreign_key "podcast_tags", "podcasts"
  add_foreign_key "podcast_tags", "tags"
  add_foreign_key "podcasts", "accounts"
  add_foreign_key "podcasts", "categories"
end
