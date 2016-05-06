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

ActiveRecord::Schema.define(version: 20160429050256) do

  create_table "admins", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "",        null: false
    t.string   "profile",                limit: 255, default: "regular", null: false
    t.string   "encrypted_password",     limit: 255, default: "",        null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          limit: 4,   default: 0,         null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip",     limit: 255
    t.string   "last_sign_in_ip",        limit: 255
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "admins", ["email"], name: "index_admins_on_email", unique: true, using: :btree
  add_index "admins", ["reset_password_token"], name: "index_admins_on_reset_password_token", unique: true, using: :btree

  create_table "available_characteristics", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.integer  "group",      limit: 4
    t.string   "options",    limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "characteristics", force: :cascade do |t|
    t.integer  "classifiable_id",             limit: 4
    t.string   "classifiable_type",           limit: 255
    t.integer  "available_characteristic_id", limit: 4
    t.integer  "group",                       limit: 4
    t.string   "option_value",                limit: 255
    t.datetime "created_at",                              null: false
    t.datetime "updated_at",                              null: false
  end

  add_index "characteristics", ["available_characteristic_id"], name: "index_characteristics_on_available_characteristic_id", using: :btree
  add_index "characteristics", ["classifiable_type", "classifiable_id"], name: "index_characteristics_on_classifiable_type_and_classifiable_id", using: :btree

  create_table "friendly_id_slugs", force: :cascade do |t|
    t.string   "slug",           limit: 255, null: false
    t.integer  "sluggable_id",   limit: 4,   null: false
    t.string   "sluggable_type", limit: 50
    t.string   "scope",          limit: 255
    t.datetime "created_at"
  end

  add_index "friendly_id_slugs", ["slug", "sluggable_type", "scope"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type_and_scope", unique: true, using: :btree
  add_index "friendly_id_slugs", ["slug", "sluggable_type"], name: "index_friendly_id_slugs_on_slug_and_sluggable_type", using: :btree
  add_index "friendly_id_slugs", ["sluggable_id"], name: "index_friendly_id_slugs_on_sluggable_id", using: :btree
  add_index "friendly_id_slugs", ["sluggable_type"], name: "index_friendly_id_slugs_on_sluggable_type", using: :btree

  create_table "properties", force: :cascade do |t|
    t.string   "title",              limit: 255
    t.text     "description",        limit: 65535
    t.integer  "status",             limit: 4,                              default: 0
    t.integer  "property_type_id",   limit: 4
    t.integer  "age",                limit: 4
    t.integer  "environments",       limit: 4
    t.integer  "garages",            limit: 4
    t.integer  "bathrooms",          limit: 4
    t.integer  "toilettes",          limit: 4
    t.integer  "sale_price",         limit: 4
    t.integer  "sale_currency",      limit: 4
    t.integer  "rent_price",         limit: 4
    t.integer  "rent_currency",      limit: 4
    t.integer  "area_unit",          limit: 4
    t.integer  "constructed_area",   limit: 4
    t.integer  "unconstructed_area", limit: 4
    t.integer  "zone_id",            limit: 4
    t.string   "address",            limit: 255
    t.string   "zip_code",           limit: 255
    t.decimal  "lat",                              precision: 10, scale: 6
    t.decimal  "lng",                              precision: 10, scale: 6
    t.datetime "created_at",                                                            null: false
    t.datetime "updated_at",                                                            null: false
  end

  add_index "properties", ["property_type_id"], name: "index_properties_on_property_type_id", using: :btree
  add_index "properties", ["zone_id"], name: "index_properties_on_zone_id", using: :btree

  create_table "property_types", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.string   "title",      limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  create_table "zones", force: :cascade do |t|
    t.string   "name",       limit: 255
    t.datetime "created_at",             null: false
    t.datetime "updated_at",             null: false
  end

  add_foreign_key "characteristics", "available_characteristics"
  add_foreign_key "properties", "property_types"
  add_foreign_key "properties", "zones"
end
