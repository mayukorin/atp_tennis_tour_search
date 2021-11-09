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

ActiveRecord::Schema.define(version: 2021_11_09_152127) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "atp_categories", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "batch_schedules", force: :cascade do |t|
    t.bigint "tournament_year_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.date "start_day"
    t.date "end_day"
    t.integer "start_hour"
    t.index ["tournament_year_id"], name: "index_batch_schedules_on_tournament_year_id"
  end

  create_table "favorites", force: :cascade do |t|
    t.bigint "player_id"
    t.bigint "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_favorites_on_player_id"
    t.index ["user_id"], name: "index_favorites_on_user_id"
  end

  create_table "matches", force: :cascade do |t|
    t.datetime "day"
    t.bigint "tournament_year_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "home_player_id"
    t.bigint "away_player_id"
    t.bigint "win_player_id"
    t.index ["away_player_id"], name: "index_matches_on_away_player_id"
    t.index ["home_player_id"], name: "index_matches_on_home_player_id"
    t.index ["tournament_year_id"], name: "index_matches_on_tournament_year_id"
    t.index ["win_player_id"], name: "index_matches_on_win_player_id"
  end

  create_table "player_matches", force: :cascade do |t|
    t.bigint "player_id", null: false
    t.bigint "match_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_player_matches_on_match_id"
    t.index ["player_id"], name: "index_player_matches_on_player_id"
  end

  create_table "players", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "ranking"
    t.integer "api_id"
  end

  create_table "responses", force: :cascade do |t|
    t.string "data"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "tour_player_matches", force: :cascade do |t|
    t.bigint "match_id"
    t.bigint "tournament_year_and_player_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["match_id"], name: "index_tour_player_matches_on_match_id"
    t.index ["tournament_year_and_player_id"], name: "index_tour_player_matches_on_tournament_year_and_player_id"
  end

  create_table "tournament_year_and_players", force: :cascade do |t|
    t.boolean "remain_flag"
    t.bigint "player_id", null: false
    t.bigint "tournament_year_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["player_id"], name: "index_tournament_year_and_players_on_player_id"
    t.index ["tournament_year_id"], name: "index_tournament_year_and_players_on_tournament_year_id"
  end

  create_table "tournament_years", force: :cascade do |t|
    t.integer "year"
    t.date "first_day"
    t.date "last_day"
    t.bigint "tournament_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "now_flag"
    t.bigint "champion_id"
    t.integer "api_id"
    t.index ["champion_id"], name: "index_tournament_years_on_champion_id"
    t.index ["tournament_id"], name: "index_tournament_years_on_tournament_id"
  end

  create_table "tournaments", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "abbreviation"
    t.string "city"
    t.bigint "atp_category_id"
    t.string "site_url"
    t.index ["atp_category_id"], name: "index_tournaments_on_atp_category_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "password_digest"
  end

  add_foreign_key "batch_schedules", "tournament_years"
  add_foreign_key "favorites", "players"
  add_foreign_key "favorites", "users"
  add_foreign_key "matches", "players", column: "away_player_id"
  add_foreign_key "matches", "players", column: "home_player_id"
  add_foreign_key "matches", "players", column: "win_player_id"
  add_foreign_key "matches", "tournament_years"
  add_foreign_key "player_matches", "matches"
  add_foreign_key "player_matches", "players"
  add_foreign_key "tour_player_matches", "matches"
  add_foreign_key "tour_player_matches", "tournament_year_and_players"
  add_foreign_key "tournament_year_and_players", "players"
  add_foreign_key "tournament_year_and_players", "tournament_years"
  add_foreign_key "tournament_years", "players", column: "champion_id"
  add_foreign_key "tournament_years", "tournaments"
  add_foreign_key "tournaments", "atp_categories"
end
