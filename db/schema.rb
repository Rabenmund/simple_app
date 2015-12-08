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

ActiveRecord::Schema.define(version: 20151027064159) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.integer  "appointable_id"
    t.string   "appointable_type"
    t.datetime "appointed_at",     null: false
  end

  add_index "appointments", ["appointable_type", "appointable_id"], name: "index_appointments_on_appointable_type_and_appointable_id", using: :btree
  add_index "appointments", ["appointed_at"], name: "index_appointments_on_appointed_at", using: :btree

  create_table "competition_plans", force: :cascade do |t|
    t.integer "federation_id", null: false
    t.string  "type",          null: false
  end

  create_table "competitions", force: :cascade do |t|
    t.string   "name",          null: false
    t.string   "type",          null: false
    t.integer  "level"
    t.integer  "federation_id", null: false
    t.integer  "season_id",     null: false
    t.datetime "start"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "competitions", ["federation_id"], name: "index_competitions_on_federation_id", using: :btree
  add_index "competitions", ["season_id"], name: "index_competitions_on_season_id", using: :btree

  create_table "competitions_teams", force: :cascade do |t|
    t.integer "competition_id"
    t.integer "team_id"
  end

  add_index "competitions_teams", ["competition_id"], name: "index_competitions_teams_on_competition_id", using: :btree
  add_index "competitions_teams", ["team_id"], name: "index_competitions_teams_on_team_id", using: :btree

  create_table "contracts", force: :cascade do |t|
    t.integer  "organization_id", null: false
    t.integer  "human_id",        null: false
    t.datetime "from",            null: false
    t.datetime "to",              null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "contracts", ["human_id"], name: "index_contracts_on_human_id", using: :btree
  add_index "contracts", ["organization_id"], name: "index_contracts_on_organization_id", using: :btree

  create_table "draws", force: :cascade do |t|
    t.string   "name",                         null: false
    t.datetime "performed_at"
    t.boolean  "finished",     default: false
    t.integer  "cup_id",                       null: false
    t.integer  "matchday_id",                  null: false
  end

  add_index "draws", ["cup_id"], name: "index_draws_on_cup_id", using: :btree
  add_index "draws", ["matchday_id"], name: "index_draws_on_matchday_id", using: :btree

  create_table "federations", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "federations", ["name"], name: "index_federations_on_name", using: :btree

  create_table "federations_seasons", id: false, force: :cascade do |t|
    t.integer "federation_id", null: false
    t.integer "season_id",     null: false
  end

  add_index "federations_seasons", ["federation_id"], name: "index_federations_seasons_on_federation_id", using: :btree
  add_index "federations_seasons", ["season_id"], name: "index_federations_seasons_on_season_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.integer  "home_id",                               null: false
    t.integer  "guest_id",                              null: false
    t.integer  "home_goals",            default: 0
    t.integer  "guest_goals",           default: 0
    t.integer  "home_half_goals"
    t.integer  "guest_half_goals"
    t.integer  "home_full_goals"
    t.integer  "guest_full_goals"
    t.integer  "home_xtra_half_goals"
    t.integer  "guest_xtra_half_goals"
    t.integer  "home_xtra_full_goals"
    t.integer  "guest_xtra_full_goals"
    t.integer  "half_second"
    t.integer  "full_second"
    t.integer  "xtra_half_second"
    t.integer  "xtra_full_second"
    t.integer  "second",                default: 0
    t.integer  "level"
    t.integer  "shots",                 default: 0
    t.datetime "performed_at"
    t.boolean  "decision",              default: false
    t.boolean  "finished",              default: false
    t.integer  "matchday_id",                           null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "games", ["guest_id"], name: "index_games_on_guest_id", using: :btree
  add_index "games", ["home_id"], name: "index_games_on_home_id", using: :btree
  add_index "games", ["matchday_id"], name: "index_games_on_matchday_id", using: :btree

  create_table "german_family_names", force: :cascade do |t|
    t.string  "name"
    t.integer "weight"
  end

  create_table "german_pre_names", force: :cascade do |t|
    t.string  "name"
    t.integer "weight"
  end

  create_table "humen", force: :cascade do |t|
    t.string   "name",       null: false
    t.date     "birthday",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "keepers_lineups", id: false, force: :cascade do |t|
    t.integer "keeper_id", null: false
    t.integer "lineup_id", null: false
  end

  add_index "keepers_lineups", ["keeper_id"], name: "index_keepers_lineups_on_keeper_id", using: :btree
  add_index "keepers_lineups", ["lineup_id"], name: "index_keepers_lineups_on_lineup_id", using: :btree

  create_table "lineup_actors", force: :cascade do |t|
    t.string   "type",           null: false
    t.integer  "lineup_id"
    t.integer  "actorable_id"
    t.string   "actorable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lineup_actors", ["actorable_type", "actorable_id"], name: "index_lineup_actors_on_actorable_type_and_actorable_id", using: :btree
  add_index "lineup_actors", ["lineup_id"], name: "index_lineup_actors_on_lineup_id", using: :btree

  create_table "lineups", force: :cascade do |t|
    t.integer  "team_id"
    t.integer  "game_id"
    t.integer  "initiative"
    t.integer  "attacking"
    t.integer  "defending"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "lineups", ["game_id", "team_id"], name: "index_lineups_on_game_id_and_team_id", using: :btree

  create_table "logical_dates", force: :cascade do |t|
    t.datetime "logical_date"
  end

  create_table "matchdays", force: :cascade do |t|
    t.integer  "number",         null: false
    t.datetime "start",          null: false
    t.string   "name"
    t.integer  "competition_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matchdays", ["competition_id"], name: "index_matchdays_on_competition_id", using: :btree
  add_index "matchdays", ["number"], name: "index_matchdays_on_number", using: :btree

  create_table "offers", force: :cascade do |t|
    t.integer  "player_id",                  null: false
    t.integer  "team_id",                    null: false
    t.integer  "reputation"
    t.boolean  "negotiated", default: false
    t.boolean  "accepted",   default: false
    t.date     "start_date"
    t.date     "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "offers", ["player_id"], name: "index_offers_on_player_id", using: :btree
  add_index "offers", ["team_id"], name: "index_offers_on_team_id", using: :btree

  create_table "organizations", force: :cascade do |t|
    t.integer  "organizable_id"
    t.string   "organizable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "organizations", ["organizable_type", "organizable_id"], name: "index_organizations_on_organizable_type_and_organizable_id", using: :btree

  create_table "players", force: :cascade do |t|
    t.integer  "keeper",     default: 0
    t.integer  "defense",    default: 0
    t.integer  "midfield",   default: 0
    t.integer  "attack",     default: 0
    t.boolean  "retired",    default: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "points", force: :cascade do |t|
    t.integer  "points"
    t.integer  "goals"
    t.integer  "against"
    t.integer  "diff"
    t.integer  "win"
    t.integer  "draw"
    t.integer  "lost"
    t.integer  "level"
    t.integer  "game_id",    null: false
    t.integer  "team_id",    null: false
    t.integer  "league_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "points", ["game_id", "team_id"], name: "index_points_on_game_id_and_team_id", using: :btree
  add_index "points", ["league_id"], name: "index_points_on_league_id", using: :btree
  add_index "points", ["team_id"], name: "index_points_on_team_id", using: :btree

  create_table "professions", force: :cascade do |t|
    t.integer "professionable_id"
    t.string  "professionable_type"
    t.integer "human_id",                           null: false
    t.boolean "active",              default: true
  end

  add_index "professions", ["human_id"], name: "index_professions_on_human_id", using: :btree
  add_index "professions", ["professionable_type", "professionable_id"], name: "index_professions_on_professionable_type_and_professionable_id", using: :btree

  create_table "results", force: :cascade do |t|
    t.integer  "points",     default: 0
    t.integer  "goals",      default: 0
    t.integer  "against",    default: 0
    t.integer  "diff",       default: 0
    t.integer  "win",        default: 0
    t.integer  "draw",       default: 0
    t.integer  "lost",       default: 0
    t.integer  "team_id",                null: false
    t.integer  "league_id",              null: false
    t.integer  "level"
    t.integer  "year"
    t.integer  "rank"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "results", ["league_id"], name: "index_results_on_league_id", using: :btree
  add_index "results", ["team_id"], name: "index_results_on_team_id", using: :btree

  create_table "season_events", force: :cascade do |t|
    t.string   "type"
    t.integer  "season_id",      null: false
    t.integer  "eventable_id"
    t.string   "eventable_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "season_events", ["eventable_type", "eventable_id"], name: "index_season_events_on_eventable_type_and_eventable_id", using: :btree

  create_table "seasons", force: :cascade do |t|
    t.integer  "year",       null: false
    t.datetime "start_date"
    t.datetime "end_date"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "seasons", ["year"], name: "index_seasons_on_year", using: :btree

  create_table "teams", force: :cascade do |t|
    t.integer  "federation_id",             null: false
    t.string   "name",                      null: false
    t.string   "short_name",                null: false
    t.string   "abbreviation",              null: false
    t.integer  "reputation",    default: 0
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "teams", ["federation_id"], name: "index_teams_on_federation_id", using: :btree
  add_index "teams", ["name"], name: "index_teams_on_name", using: :btree

  create_table "teardowns", force: :cascade do |t|
    t.integer  "teardownable_id"
    t.string   "teardownable_type"
    t.datetime "performed_at",      null: false
  end

  add_index "teardowns", ["teardownable_type", "teardownable_id"], name: "index_teardowns_on_teardownable_type_and_teardownable_id", using: :btree

end
