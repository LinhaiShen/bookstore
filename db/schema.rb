# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_08_19_061820) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "book_order_lines", force: :cascade do |t|
    t.integer "linenumber"
    t.integer "status"
    t.bigint "book_id", null: false
    t.integer "qty"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "book_order_id", default: 1, null: false
    t.index ["book_id"], name: "index_book_order_lines_on_book_id"
    t.index ["book_order_id"], name: "index_book_order_lines_on_book_order_id"
  end

  create_table "book_orders", force: :cascade do |t|
    t.string "refnumber"
    t.integer "status"
    t.datetime "deliverytime"
    t.string "deliveryaddress"
    t.text "notes"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "assignee_id"
    t.index ["assignee_id"], name: "index_book_orders_on_assignee_id"
  end

  create_table "books", force: :cascade do |t|
    t.string "name"
    t.string "author"
    t.string "isbn"
    t.integer "numberofpages"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "dusers", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "group"
    t.string "name"
    t.index ["email"], name: "index_dusers_on_email", unique: true
    t.index ["reset_password_token"], name: "index_dusers_on_reset_password_token", unique: true
  end

  create_table "dusers_roles", id: false, force: :cascade do |t|
    t.bigint "duser_id", null: false
    t.bigint "role_id", null: false
  end

  create_table "locations", force: :cascade do |t|
    t.integer "ops"
    t.integer "loctype"
    t.integer "container"
    t.string "building"
    t.string "room"
    t.string "aisle"
    t.string "face"
    t.integer "column"
    t.integer "layer"
    t.integer "containercapa"
    t.integer "weightcapa"
    t.integer "heightcapa"
    t.integer "volumecapa"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "code"
    t.string "type"
    t.index ["code"], name: "index_locations_on_code", unique: true
  end

  create_table "roles", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "email"
    t.string "password_digest"
    t.string "first_name"
    t.string "last_name"
    t.string "remember_token"
    t.datetime "remember_token_expires_at"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  add_foreign_key "book_order_lines", "book_orders"
  add_foreign_key "book_order_lines", "books"
  add_foreign_key "book_orders", "dusers", column: "assignee_id"
end
