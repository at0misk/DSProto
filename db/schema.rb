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

ActiveRecord::Schema.define(version: 20170116221627) do

  create_table "carts", force: :cascade do |t|
    t.integer  "user_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "carts", ["user_id"], name: "index_carts_on_user_id"

  create_table "cats", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "creds", force: :cascade do |t|
    t.integer  "user_id"
    t.string   "patterson_u"
    t.string   "patterson_p"
    t.string   "safco_u"
    t.string   "safco_p"
    t.string   "darby_u"
    t.string   "darby_p"
    t.string   "henry_u"
    t.string   "henry_p"
    t.string   "benco_u"
    t.string   "benco_p"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "creds", ["user_id"], name: "index_creds_on_user_id"

  create_table "prices", force: :cascade do |t|
    t.string   "distributor"
    t.string   "price"
    t.string   "quantity"
    t.integer  "product_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
  end

  add_index "prices", ["product_id"], name: "index_prices_on_product_id"

  create_table "prods", force: :cascade do |t|
    t.string   "name"
    t.string   "manufacturer_number"
    t.string   "manufacturer"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
    t.string   "product_code"
    t.string   "product_detail"
    t.string   "code"
  end

  create_table "products", force: :cascade do |t|
    t.integer  "cart_id"
    t.string   "name"
    t.string   "price"
    t.integer  "quantity"
    t.string   "manufacturer"
    t.string   "manufacturer_number"
    t.string   "distributor"
    t.string   "distributor_number"
    t.datetime "created_at",          null: false
    t.datetime "updated_at",          null: false
  end

  add_index "products", ["cart_id"], name: "index_products_on_cart_id"

  create_table "users", force: :cascade do |t|
    t.string   "first"
    t.string   "last"
    t.string   "email"
    t.string   "password_digest"
    t.string   "office"
    t.string   "city"
    t.string   "state"
    t.string   "phone"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

end
