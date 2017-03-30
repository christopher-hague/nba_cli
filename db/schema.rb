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

ActiveRecord::Schema.define(version: 20170330204752) do

  create_table "authors", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "book_genres", force: :cascade do |t|
    t.integer  "book_id"
    t.integer  "genre_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "books", force: :cascade do |t|
    t.string   "title"
    t.integer  "author_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "genres", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "players", force: :cascade do |t|
    t.text    "first_name"
    t.text    "last_name"
    t.integer "number"
    t.text    "pos"
    t.integer "total_pts"
    t.string  "ppg"
    t.integer "ast"
    t.string  "apg"
    t.integer "reb"
    t.string  "rpg"
    t.integer "to"
    t.string  "topg"
    t.integer "mins"
    t.string  "mpg"
    t.integer "fg"
    t.integer "fg_att"
    t.string  "fg_pct"
    t.integer "fg_3pt_att"
    t.integer "fg_3pt"
    t.string  "fg_3pt_pg"
    t.integer "stl"
    t.string  "spg"
    t.integer "blk"
    t.string  "blk_pg"
    t.integer "pf"
    t.string  "pf_pg"
    t.string  "full_name"
  end

  create_table "schedules", force: :cascade do |t|
    t.string "date"
    t.string "away_team"
    t.string "home_team"
    t.string "location"
  end

  create_table "teams", force: :cascade do |t|
    t.text    "name"
    t.text    "city"
    t.integer "wins"
    t.integer "losses"
    t.float   "win_pct"
    t.integer "league_ranking"
    t.integer "total_pts"
    t.float   "ppg"
    t.float   "fg_pct"
    t.float   "fg_pct_three_pt"
    t.integer "reb"
    t.float   "rpg"
    t.integer "off_reb"
    t.float   "orpg"
    t.integer "ast"
    t.float   "apg"
    t.integer "to"
    t.float   "topg"
    t.integer "stl"
    t.float   "spg"
  end

end
