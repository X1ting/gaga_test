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

ActiveRecord::Schema.define(version: 20160322080625) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "start_at",   null: false
    t.datetime "end_at",     null: false
    t.decimal  "longitude",  null: false
    t.decimal  "latitude",   null: false
    t.string   "address",    null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "events_games", id: false, force: :cascade do |t|
    t.integer "event_id"
    t.integer "game_id"
  end

  add_index "events_games", ["event_id"], name: "index_events_games_on_event_id", using: :btree
  add_index "events_games", ["game_id"], name: "index_events_games_on_game_id", using: :btree

  create_table "games", force: :cascade do |t|
    t.string   "name",       null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

end
