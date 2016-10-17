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

ActiveRecord::Schema.define(version: 20161016173954) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "accounts", force: :cascade do |t|
    t.string   "account_name"
    t.boolean  "account_active"
    t.datetime "created_at",     null: false
    t.datetime "updated_at",     null: false
  end

  create_table "cart_items", force: :cascade do |t|
    t.integer  "item_id"
    t.integer  "qty"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.integer  "cart_id"
    t.date     "arrival_date"
    t.string   "status_code",  default: "O"
    t.string   "status_text"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_cart_items_on_account_id", using: :btree
    t.index ["cart_id"], name: "index_cart_items_on_cart_id", using: :btree
    t.index ["item_id"], name: "index_cart_items_on_item_id", using: :btree
  end

  create_table "carts", force: :cascade do |t|
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "process_status"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_carts_on_account_id", using: :btree
    t.index ["from_location_id"], name: "index_carts_on_from_location_id", using: :btree
    t.index ["to_location_id"], name: "index_carts_on_to_location_id", using: :btree
  end

  create_table "inventories", force: :cascade do |t|
    t.integer  "qty"
    t.integer  "location_id"
    t.integer  "item_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.date     "arrival_date"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_inventories_on_account_id", using: :btree
    t.index ["item_id"], name: "index_inventories_on_item_id", using: :btree
    t.index ["location_id"], name: "index_inventories_on_location_id", using: :btree
  end

  create_table "invitations", force: :cascade do |t|
    t.string   "to_email"
    t.string   "from_email"
    t.string   "token"
    t.integer  "invitation_type"
    t.integer  "status"
    t.date     "expiry_date"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
    t.integer  "accounts_id"
    t.index ["accounts_id"], name: "index_invitations_on_accounts_id", using: :btree
  end

  create_table "item_fields", force: :cascade do |t|
    t.string   "name"
    t.string   "field_type"
    t.boolean  "required"
    t.integer  "item_type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_item_fields_on_account_id", using: :btree
    t.index ["item_type_id"], name: "index_item_fields_on_item_type_id", using: :btree
  end

  create_table "item_searches", force: :cascade do |t|
    t.integer  "item_type_id"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
  end

  create_table "item_types", force: :cascade do |t|
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer  "account_id"
    t.index ["account_id"], name: "index_item_types_on_account_id", using: :btree
  end

  create_table "items", force: :cascade do |t|
    t.string   "name",         null: false
    t.string   "description"
    t.datetime "created_at",   null: false
    t.datetime "updated_at",   null: false
    t.integer  "item_type_id"
    t.text     "properties"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_items_on_account_id", using: :btree
    t.index ["name"], name: "index_items_on_name", unique: true, using: :btree
  end

  create_table "locations", force: :cascade do |t|
    t.string   "name"
    t.string   "location_type"
    t.datetime "created_at",           null: false
    t.datetime "updated_at",           null: false
    t.string   "ancestry"
    t.integer  "default_item_type_id"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_locations_on_account_id", using: :btree
  end

  create_table "transaction_types", force: :cascade do |t|
    t.string   "description"
    t.integer  "from_location_id"
    t.integer  "to_location_id"
    t.datetime "created_at",       null: false
    t.datetime "updated_at",       null: false
    t.string   "name"
    t.integer  "account_id"
    t.index ["account_id"], name: "index_transaction_types_on_account_id", using: :btree
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
    t.integer  "account_id"
    t.index ["account_id"], name: "index_transactions_on_account_id", using: :btree
    t.index ["from_location_id"], name: "index_transactions_on_from_location_id", using: :btree
    t.index ["items_id"], name: "index_transactions_on_items_id", using: :btree
    t.index ["to_location_id"], name: "index_transactions_on_to_location_id", using: :btree
  end

  create_table "user_accounts", force: :cascade do |t|
    t.boolean  "account_admin", default: false
    t.integer  "user_id"
    t.integer  "account_id"
    t.datetime "created_at",                    null: false
    t.datetime "updated_at",                    null: false
    t.index ["account_id"], name: "index_user_accounts_on_account_id", using: :btree
    t.index ["user_id"], name: "index_user_accounts_on_user_id", using: :btree
  end

  create_table "users", force: :cascade do |t|
    t.string   "email",                  default: "",    null: false
    t.string   "encrypted_password",     default: "",    null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,     null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at",                             null: false
    t.datetime "updated_at",                             null: false
    t.string   "firstname"
    t.string   "lastname"
    t.string   "address"
    t.string   "postcode"
    t.string   "postname"
    t.string   "country"
    t.boolean  "global_admin",           default: false
    t.integer  "current_account_id"
    t.index ["current_account_id"], name: "index_users_on_current_account_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

  add_foreign_key "cart_items", "accounts"
  add_foreign_key "cart_items", "carts"
  add_foreign_key "cart_items", "items"
  add_foreign_key "carts", "accounts"
  add_foreign_key "inventories", "accounts"
  add_foreign_key "inventories", "items"
  add_foreign_key "inventories", "locations"
  add_foreign_key "invitations", "accounts", column: "accounts_id"
  add_foreign_key "item_fields", "accounts"
  add_foreign_key "item_fields", "item_types"
  add_foreign_key "item_types", "accounts"
  add_foreign_key "items", "accounts"
  add_foreign_key "locations", "accounts"
  add_foreign_key "transaction_types", "accounts"
  add_foreign_key "transactions", "accounts"
  add_foreign_key "user_accounts", "accounts"
  add_foreign_key "user_accounts", "users"
end
