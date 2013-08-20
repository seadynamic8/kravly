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

ActiveRecord::Schema.define(version: 20130719210115) do

  create_table "boards", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "boards", ["user_id"], name: "index_boards_on_user_id", using: :btree

  create_table "boards_ideas", id: false, force: true do |t|
    t.integer "board_id", null: false
    t.integer "idea_id",  null: false
  end

  add_index "boards_ideas", ["board_id", "idea_id"], name: "index_boards_ideas_on_board_id_and_idea_id", using: :btree
  add_index "boards_ideas", ["idea_id", "board_id"], name: "index_boards_ideas_on_idea_id_and_board_id", using: :btree

  create_table "comments", force: true do |t|
    t.text     "content"
    t.integer  "idea_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "comments", ["idea_id"], name: "index_comments_on_idea_id", using: :btree

  create_table "ideas", force: true do |t|
    t.string   "title"
    t.text     "content"
    t.integer  "votes"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "ideas", ["user_id"], name: "index_ideas_on_user_id", using: :btree

  create_table "users", force: true do |t|
    t.string   "username"
    t.string   "email"
    t.string   "firstname"
    t.string   "lastname"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
