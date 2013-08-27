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

ActiveRecord::Schema.define(version: 20130827005045) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "domains", force: true do |t|
    t.string   "url"
    t.integer  "site_id"
    t.boolean  "ssl_enabled"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "domains", ["site_id"], name: "index_domains_on_site_id"

  create_table "plans", force: true do |t|
    t.string   "remote_id"
    t.decimal  "price",       precision: 8, scale: 2
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "sites", force: true do |t|
    t.integer  "client_id"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["client_id"], name: "index_sites_on_client_id"
  add_index "sites", ["plan_id"], name: "index_sites_on_plan_id"

end
