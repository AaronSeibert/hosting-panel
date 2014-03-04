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

ActiveRecord::Schema.define(version: 20140304154831) do

  create_table "clients", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "stripe_customer_id"
    t.string   "address_one"
    t.string   "address_two"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.string   "billing_email"
    t.string   "contact_name"
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
    t.decimal  "price",          precision: 8, scale: 2
    t.text     "description"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "interval"
    t.integer  "interval_count"
    t.boolean  "prorate"
    t.boolean  "multiple"
  end

  create_table "sites", force: true do |t|
    t.integer  "client_id"
    t.integer  "plan_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "sites", ["client_id"], name: "index_sites_on_client_id"
  add_index "sites", ["plan_id"], name: "index_sites_on_plan_id"

  create_table "subscriptions", force: true do |t|
    t.integer  "client_id"
    t.integer  "plan_id"
    t.date     "next_bill_date"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.date     "last_invoiced"
    t.integer  "site_id"
    t.text     "description"
    t.integer  "quantity",       default: 1
  end

  add_index "subscriptions", ["client_id"], name: "index_subscriptions_on_client_id"
  add_index "subscriptions", ["plan_id"], name: "index_subscriptions_on_plan_id"
  add_index "subscriptions", ["site_id"], name: "index_subscriptions_on_site_id"

  create_table "users", force: true do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
