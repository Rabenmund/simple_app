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

ActiveRecord::Schema.define(version: 20131230162323) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "games", force: true do |t|
    t.integer  "home_id",                     null: false
    t.integer  "guest_id",                    null: false
    t.integer  "home_goals"
    t.integer  "guest_goals"
    t.integer  "matchday_id",                 null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "finished",    default: false
    t.integer  "second",      default: 0
  end

  add_index "games", ["guest_id"], name: "index_games_on_guest_id", using: :btree
  add_index "games", ["home_id"], name: "index_games_on_home_id", using: :btree

  create_table "leagues", force: true do |t|
    t.string   "name",       null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "leagues_teams", id: false, force: true do |t|
    t.integer "league_id"
    t.integer "team_id"
  end

  add_index "leagues_teams", ["league_id", "team_id"], name: "index_leagues_teams_on_league_id_and_team_id", using: :btree

  create_table "matchdays", force: true do |t|
    t.integer  "number",     null: false
    t.integer  "league_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "matchdays", ["number"], name: "index_matchdays_on_number", using: :btree

  create_table "points", force: true do |t|
    t.integer  "points"
    t.integer  "goals"
    t.integer  "against"
    t.integer  "diff"
    t.integer  "win"
    t.integer  "draw"
    t.integer  "lost"
    t.integer  "game_id",    null: false
    t.integer  "team_id",    null: false
    t.integer  "league_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name",         null: false
    t.string   "short_name",   null: false
    t.string   "abbreviation", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
