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

ActiveRecord::Schema.define(version: 20140313235853) do

  create_table "companies", force: true do |t|
    t.string   "name"
    t.string   "phone"
    t.boolean  "activated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "devices", force: true do |t|
    t.integer  "company_id"
    t.string   "unique_id"
    t.integer  "user_id"
    t.boolean  "activated"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "devices", ["company_id"], name: "index_devices_on_company_id"
  add_index "devices", ["user_id"], name: "index_devices_on_user_id"

  create_table "fertilizers", force: true do |t|
    t.string   "name"
    t.float    "n_total"
    t.float    "n_nh4"
    t.float    "n_no3"
    t.float    "p2o5"
    t.float    "k20"
    t.float    "cao"
    t.float    "s"
    t.float    "mgo"
    t.float    "b"
    t.float    "zn"
    t.float    "na"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "instances", force: true do |t|
    t.integer  "company_id"
    t.text     "json"
    t.float    "version"
    t.integer  "device_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
  end

  add_index "instances", ["company_id"], name: "index_instances_on_company_id"
  add_index "instances", ["device_id"], name: "index_instances_on_device_id"

  create_table "items_sites", force: true do |t|
    t.integer  "site_id"
    t.float    "lat"
    t.float    "lng"
    t.float    "speed"
    t.datetime "ts"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.float    "accuracy"
    t.float    "altitude"
    t.float    "bearing"
  end

  add_index "items_sites", ["site_id"], name: "index_items_sites_on_site_id"

  create_table "menus", force: true do |t|
    t.integer  "sequence"
    t.string   "name"
    t.integer  "role_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "menus", ["role_id"], name: "index_menus_on_role_id"

  create_table "mixtures", force: true do |t|
    t.string   "name"
    t.float    "n"
    t.float    "p2o5"
    t.float    "k20"
    t.float    "cao"
    t.float    "s"
    t.float    "mgo"
    t.float    "b"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "roles", force: true do |t|
    t.string   "name"
    t.boolean  "activated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "open_path"
  end

  create_table "sites", force: true do |t|
    t.integer  "company_id"
    t.string   "name"
    t.boolean  "activated"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "user_id"
    t.text     "comments"
  end

  add_index "sites", ["company_id"], name: "index_sites_on_company_id"

  create_table "users", force: true do |t|
    t.string   "name",                   default: "", null: false
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
    t.string   "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string   "unconfirmed_email"
    t.string   "authentication_token"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "role_id"
  end

  add_index "users", ["authentication_token"], name: "index_users_on_authentication_token", unique: true
  add_index "users", ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end
