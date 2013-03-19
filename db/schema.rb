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
# It's strongly recommended to check this file into your version control system.

ActiveRecord::Schema.define(:version => 20130318163610) do

  create_table "competitions", :force => true do |t|
    t.string   "name",       :null => false
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "competitions_teams", :id => false, :force => true do |t|
    t.integer "competition_id"
    t.integer "team_id"
  end

  add_index "competitions_teams", ["competition_id", "team_id"], :name => "index_competitions_teams_on_competition_id_and_team_id"

  create_table "games", :force => true do |t|
    t.integer  "home_id",     :null => false
    t.integer  "guest_id",    :null => false
    t.integer  "home_goals"
    t.integer  "guest_goals"
    t.integer  "matchday_id", :null => false
    t.datetime "created_at",  :null => false
    t.datetime "updated_at",  :null => false
  end

  add_index "games", ["guest_id"], :name => "index_games_on_guest_id"
  add_index "games", ["home_id"], :name => "index_games_on_home_id"

  create_table "matchdays", :force => true do |t|
    t.integer  "number",         :null => false
    t.integer  "competition_id", :null => false
    t.datetime "created_at",     :null => false
    t.datetime "updated_at",     :null => false
  end

  create_table "teams", :force => true do |t|
    t.string   "name",         :null => false
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
    t.string   "short_name",   :null => false
    t.string   "abbreviation", :null => false
  end

end
