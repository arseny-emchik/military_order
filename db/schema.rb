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

ActiveRecord::Schema.define(version: 20140403151721) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "lessons", force: true do |t|
    t.integer "hours", null: false
    t.date    "date",  null: false
  end

  create_table "patrols", force: true do |t|
    t.date     "patrol_start", null: false
    t.date     "patrol_end",   null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "ranks", force: true do |t|
    t.string "title", null: false
  end

  create_table "soldiers", force: true do |t|
    t.string  "surname",    null: false
    t.string  "name",       null: false
    t.string  "patronymic", null: false
    t.integer "rank_id"
  end

end
