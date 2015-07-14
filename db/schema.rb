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

ActiveRecord::Schema.define(version: 20150714024856) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "admin_user_details", force: :cascade do |t|
  end

  create_table "end_user_details", force: :cascade do |t|
    t.string "city",    limit: 22
    t.string "state",   limit: 2
    t.string "zip",     limit: 9
    t.string "gender",  limit: 9
    t.string "phone",   limit: 10
    t.text   "address"
  end

  create_table "users", force: :cascade do |t|
    t.string  "first_name"
    t.string  "last_name"
    t.integer "details_id"
    t.string  "details_type"
    t.string  "email"
    t.string  "password_digest"
  end

  add_index "users", ["details_type", "details_id"], name: "index_users_on_details_type_and_details_id", using: :btree

end
