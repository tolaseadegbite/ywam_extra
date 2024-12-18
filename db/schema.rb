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

ActiveRecord::Schema[7.1].define(version: 2024_11_17_102231) do
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

  create_table "comments", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.text "body", null: false
    t.string "commentable_type", null: false
    t.bigint "commentable_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_comments_on_account_id"
    t.index ["commentable_type", "commentable_id"], name: "index_comments_on_commentable"
  end

  create_table "episode_progresses", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "episode_id", null: false
    t.float "progress"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_episode_progresses_on_account_id"
    t.index ["episode_id"], name: "index_episode_progresses_on_episode_id"
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
    t.text "description", null: false
    t.bigint "podcast_id", null: false
    t.bigint "category_id", null: false
    t.integer "follows_count", default: 0, null: false
    t.integer "saves_count", default: 0, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "episode_type", default: 0, null: false
    t.integer "status", default: 0
    t.index ["category_id"], name: "index_episodes_on_category_id"
    t.index ["podcast_id"], name: "index_episodes_on_podcast_id"
  end

  create_table "event_co_hosts", force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "account_id", null: false
    t.integer "role", default: 1
    t.integer "status", default: 0
    t.integer "decline_count", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_event_co_hosts_on_account_id"
    t.index ["event_id", "account_id"], name: "index_event_co_hosts_on_event_id_and_account_id", unique: true
    t.index ["event_id"], name: "index_event_co_hosts_on_event_id"
  end

  create_table "events", force: :cascade do |t|
    t.string "name", null: false
    t.date "start_date", null: false
    t.date "end_date", null: false
    t.time "start_time", null: false
    t.time "end_time", null: false
    t.text "details", null: false
    t.string "street_address"
    t.string "streaming_link"
    t.bigint "account_id", null: false
    t.bigint "category_id", null: false
    t.integer "event_type", null: false
    t.integer "cost_type", null: false
    t.string "country"
    t.string "state"
    t.string "city"
    t.string "time_zone"
    t.integer "status", default: 0
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "location"
    t.string "streaming_platform"
    t.string "booking_url"
    t.integer "audience", default: 0
    t.index ["account_id"], name: "index_events_on_account_id"
    t.index ["category_id"], name: "index_events_on_category_id"
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

  create_table "playlist_episodes", force: :cascade do |t|
    t.bigint "playlist_id", null: false
    t.bigint "episode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["episode_id"], name: "index_playlist_episodes_on_episode_id"
    t.index ["playlist_id"], name: "index_playlist_episodes_on_playlist_id"
  end

  create_table "playlists", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.string "name", null: false
    t.text "description"
    t.integer "visibility", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_playlists_on_account_id"
  end

  create_table "plays", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "episode_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id", "episode_id"], name: "index_plays_on_account_id_and_episode_id", unique: true
    t.index ["account_id"], name: "index_plays_on_account_id"
    t.index ["episode_id"], name: "index_plays_on_episode_id"
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
    t.text "about", null: false
    t.integer "episodes_count", default: 0, null: false
    t.integer "follows_count", default: 0, null: false
    t.bigint "account_id", null: false
    t.bigint "category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "reviews_count", default: 0
    t.decimal "average_rating", default: "0.0"
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

  create_table "reviews", force: :cascade do |t|
    t.integer "rating", null: false
    t.text "comment"
    t.string "reviewable_type", null: false
    t.bigint "reviewable_id", null: false
    t.bigint "account_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_reviews_on_account_id"
    t.index ["reviewable_type", "reviewable_id"], name: "index_reviews_on_reviewable"
  end

  create_table "rsvps", force: :cascade do |t|
    t.bigint "account_id", null: false
    t.bigint "event_id", null: false
    t.integer "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["account_id"], name: "index_rsvps_on_account_id"
    t.index ["event_id"], name: "index_rsvps_on_event_id"
  end

  create_table "tags", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_foreign_key "active_storage_attachments", "active_storage_blobs", column: "blob_id"
  add_foreign_key "active_storage_variant_records", "active_storage_blobs", column: "blob_id"
  add_foreign_key "comments", "accounts"
  add_foreign_key "episode_progresses", "accounts"
  add_foreign_key "episode_progresses", "episodes"
  add_foreign_key "episode_tags", "episodes"
  add_foreign_key "episode_tags", "tags"
  add_foreign_key "episodes", "categories"
  add_foreign_key "episodes", "podcasts"
  add_foreign_key "event_co_hosts", "accounts"
  add_foreign_key "event_co_hosts", "events"
  add_foreign_key "events", "accounts"
  add_foreign_key "events", "categories"
  add_foreign_key "follows", "accounts"
  add_foreign_key "playlist_episodes", "episodes"
  add_foreign_key "playlist_episodes", "playlists"
  add_foreign_key "playlists", "accounts"
  add_foreign_key "plays", "accounts"
  add_foreign_key "plays", "episodes"
  add_foreign_key "podcast_tags", "podcasts"
  add_foreign_key "podcast_tags", "tags"
  add_foreign_key "podcasts", "accounts"
  add_foreign_key "podcasts", "categories"
  add_foreign_key "reviews", "accounts"
  add_foreign_key "rsvps", "accounts"
  add_foreign_key "rsvps", "events"
end
