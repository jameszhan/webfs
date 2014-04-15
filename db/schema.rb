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

ActiveRecord::Schema.define(version: 20140101152415) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "authors", force: true do |t|
    t.string   "first_name"
    t.string   "middle_name"
    t.string   "last_name"
    t.string   "aliases",     default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "blobs", force: true do |t|
    t.string   "digest"
    t.string   "uri"
    t.string   "size"
    t.string   "content_type"
    t.string   "name"
    t.datetime "modified_at"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "books", force: true do |t|
    t.string   "title"
    t.string   "aliases",    default: [], array: true
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "districts", force: true do |t|
    t.string   "code"
    t.string   "name"
    t.string   "type"
    t.float    "longitude"
    t.float    "latitude"
    t.float    "area"
    t.string   "abbr"
    t.integer  "postal"
    t.string   "area_code"
    t.string   "level"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "districts", ["code"], name: "index_districts_on_code", unique: true, using: :btree

  create_table "inodes", force: true do |t|
    t.string   "digest"
    t.string   "uri"
    t.integer  "size",         limit: 8
    t.string   "content_type"
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

end
