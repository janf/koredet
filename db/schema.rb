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

ActiveRecord::Schema.define(version: 20160912040953) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "cart_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "qty"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "cart_id"
    t.index ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
    t.index ["item_id"], name: "index_cart_items_on_item_id", using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "process_status"
    t.index ["from_location_id"], name: "index_carts_on_from_location_id", using: :btree
    t.index ["to_location_id"], name: "index_carts_on_to_location_id", using: :btree
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "qty"
    t.integer  "location_id"
    t.integer  "item_id"
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.index ["item_id"], name: "index_inventories_on_item_id", using: :btree
    t.index ["location_id"], name: "index_inventories_on_location_id", using: :btree
  end

  create_table "item_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "item_type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.index ["item_type_id"], name: "index_item_fields_on_item_type_id", using: :btree
  end

  create_table "item_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "items", force: :cascade do |t|
    t.string   "name"
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "item_type_id"
    t.text     "properties"
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "location_type"
    t.datetime "created_at",    null: false
    t.datetime "updated_at",    null: false
    t.string   "ancestry"
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string   "description"
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.index ["from_location_id"], name: "index_transaction_types_on_from_location_id", using: :btree
    t.index ["to_location_id"], name: "index_transaction_types_on_to_location_id", using: :btree
  end

  create_table "transactions", force: :cascade do |t|
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.integer  "items_id"
    t.integer  "qty"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.index ["from_location_id"], name: "index_transactions_on_from_location_id", using: :btree
    t.index ["items_id"], name: "index_transactions_on_items_id", using: :btree
    t.index ["to_location_id"], name: "index_transactions_on_to_location_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "", null: false
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "items"
  add_foreign_key "inventories", "items"
  add_foreign_key "inventories", "locations"
  add_foreign_key "item_fields", "item_types"
end
