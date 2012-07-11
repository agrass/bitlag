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

ActiveRecord::Schema.define(:version => 20120711220253) do

  create_table "events", :force => true do |t|
    t.string   "name"
    t.string   "address"
    t.float    "longitude"
    t.float    "latitude"
    t.boolean  "gmaps"
    t.string   "description"
    t.datetime "start_time"
    t.datetime "end_time"
    t.string   "location"
    t.integer  "fb_id",       :limit => 8
    t.integer  "owner_id",    :limit => 8
    t.string   "city"
    t.string   "country"
    t.text     "picture",     :limit => 255
    t.integer  "atenders"
    t.string   "privacy"
    t.datetime "created_at",                 :null => false
    t.datetime "updated_at",                 :null => false
  end

  create_table "events_tags", :id => false, :force => true do |t|
    t.integer "event_id"
    t.integer "tag_id"
  end

  add_index "events_tags", ["event_id", "tag_id"], :name => "index_events_tags_on_event_id_and_tag_id"

  create_table "expressions", :force => true do |t|
    t.integer  "tag_id"
    t.string   "expression"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  add_index "expressions", ["tag_id"], :name => "index_expressions_on_tag_id"

  create_table "fb_infos", :force => true do |t|
    t.string   "fb_id"
    t.string   "access_token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

  create_table "tags", :force => true do |t|
    t.string   "name"
    t.datetime "created_at", :null => false
    t.datetime "updated_at", :null => false
  end

  create_table "users", :force => true do |t|
    t.string   "fb_id"
    t.string   "access_token"
    t.datetime "created_at",   :null => false
    t.datetime "updated_at",   :null => false
  end

end
