# encoding: UTF-8
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

ActiveRecord::Schema.define(version: 20160724022527) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "actor_searches", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "album_searches", force: :cascade do |t|
    t.integer  "album_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "albums", force: :cascade do |t|
    t.string   "name"
    t.date     "release_date"
    t.string   "album_type"
    t.string   "spotify_id"
    t.integer  "spotify_popularity"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "cover_url"
    t.integer  "total_tracks"
  end

  create_table "artist_albums", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "album_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artist_genres", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "music_genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "artist_searches", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "artists", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.integer  "spotify_popularity"
    t.string   "spotify_url"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "author_searches", force: :cascade do |t|
    t.integer  "creator_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_authors", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_genres", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "book_searches", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "name"
    t.date     "release_date"
    t.string   "isbn"
    t.text     "cover_url"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "goodreads_id"
  end

  create_table "creators", force: :cascade do |t|
    t.string   "name"
    t.string   "spotify_id"
    t.integer  "spotify_popularity"
    t.string   "spotify_url"
    t.date     "date_of_birth"
    t.date     "date_of_death"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tmdb_id"
    t.integer  "goodreads_id"
    t.string   "spotify_image_url"
  end

  create_table "director_searches", force: :cascade do |t|
    t.integer  "search_id"
    t.integer  "creator_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "tmdb_id"
  end

  create_table "list_items", force: :cascade do |t|
    t.string   "name"
    t.integer  "item_id"
    t.string   "item_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "user_id"
  end

  create_table "movie_actors", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_directors", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "movie_genres", force: :cascade do |t|
    t.integer  "movie_id",   null: false
    t.integer  "genre_id",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "movie_genres", ["movie_id", "genre_id"], name: "index_movie_genres_on_movie_id_and_genre_id", unique: true, using: :btree

  create_table "movie_searches", force: :cascade do |t|
    t.integer  "movie_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "movies", force: :cascade do |t|
    t.string   "name"
    t.date     "release_date"
    t.integer  "critics_score"
    t.integer  "audience_score"
    t.text     "critics_consensus"
    t.string   "poster_link"
    t.string   "rating"
    t.string   "rt_link"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "trailer_link"
    t.integer  "tmdb_id"
    t.string   "mpaa_rating"
    t.string   "imdb_id"
    t.integer  "budget"
    t.string   "homepage"
    t.string   "original_language"
    t.text     "overview"
    t.integer  "revenue"
    t.integer  "runtime"
    t.string   "release_status"
  end

  create_table "music_genres", force: :cascade do |t|
    t.string   "name",       null: false
    t.string   "spotify_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "requested_items", force: :cascade do |t|
    t.string   "name"
    t.string   "requested_type"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "searches", force: :cascade do |t|
    t.string   "name"
    t.string   "type"
    t.integer  "list_item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "show_actors", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_creators", force: :cascade do |t|
    t.integer  "show_id",    null: false
    t.integer  "creator_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "show_creators", ["creator_id"], name: "index_show_creators_on_creator_id", using: :btree
  add_index "show_creators", ["show_id"], name: "index_show_creators_on_show_id", using: :btree

  create_table "show_directors", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "creator_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_genres", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "genre_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "show_searches", force: :cascade do |t|
    t.integer  "show_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "shows", force: :cascade do |t|
    t.string   "name"
    t.date     "first_air_date"
    t.date     "last_air_date"
    t.string   "status"
    t.integer  "number_of_seasons"
    t.integer  "number_of_episodes"
    t.integer  "tmdb_id"
    t.text     "overview"
    t.integer  "imdb_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.text     "episode_run_time",   default: [], array: true
    t.string   "homepage"
    t.boolean  "in_production"
    t.string   "original_language"
    t.string   "poster_link"
  end

  create_table "song_searches", force: :cascade do |t|
    t.integer  "song_id"
    t.integer  "search_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "songs", force: :cascade do |t|
    t.string   "name"
    t.integer  "duration_ms"
    t.string   "spotify_preview_url"
    t.string   "spotify_url"
    t.integer  "spotify_popularity"
    t.string   "spotify_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "album_id"
    t.integer  "disc_number"
    t.integer  "track_number"
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "movie_genres", "genres"
  add_foreign_key "movie_genres", "movies"
end
