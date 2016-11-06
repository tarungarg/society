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

ActiveRecord::Schema.define(version: 20161106031246) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "complaints", force: :cascade do |t|
    t.string   "title"
    t.text     "desc"
    t.integer  "status"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "roles", force: :cascade do |t|
    t.string   "name"
    t.integer  "resource_id"
    t.string   "resource_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "roles", ["name", "resource_type", "resource_id"], name: "index_roles_on_name_and_resource_type_and_resource_id", using: :btree
  add_index "roles", ["name"], name: "index_roles_on_name", using: :btree

  create_table "society_profiles", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "society_name"
    t.string   "mobile_number"
    t.string   "street_addr"
    t.string   "city"
    t.string   "state"
    t.string   "zip"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
  end

  create_table "tenants", force: :cascade do |t|
    t.string   "name"
    t.string   "domain"
    t.string   "image_url"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "tenants", ["domain"], name: "index_tenants_on_domain", using: :btree

  create_table "tenants_users", force: :cascade do |t|
    t.integer "user_id",   null: false
    t.integer "tenant_id", null: false
  end

  add_index "tenants_users", ["tenant_id"], name: "index_tenants_users_on_tenants_id", using: :btree
  add_index "tenants_users", ["user_id"], name: "index_tenants_users_on_user_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "name"
    t.string   "flat_no"
    t.string   "tower_no"
    t.string   "alt_no"
    t.string   "blood_group"
    t.string   "occupation"
    t.integer  "family_memebers",        default: 0
    t.integer  "adult",                  default: 0
    t.integer  "kids",                   default: 0
    t.text     "bio"
    t.string   "mob_num",                default: ""
    t.string   "email",                  default: ""
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.integer  "tenant_id"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["mob_num"], name: "index_users_on_mob_num", using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "users_roles", id: false, force: :cascade do |t|
    t.integer "user_id"
    t.integer "role_id"
  end

  add_index "users_roles", ["user_id", "role_id"], name: "index_users_roles_on_user_id_and_role_id", using: :btree

end
