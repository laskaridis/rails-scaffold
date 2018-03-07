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

ActiveRecord::Schema.define(version: 20180307080931) do

  create_table "addresses", force: :cascade do |t|
    t.string "street", null: false
    t.string "city", null: false
    t.string "region", null: false
    t.string "postal_code", null: false
    t.integer "country_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["country_id"], name: "index_addresses_on_country_id"
  end

  create_table "contacts", force: :cascade do |t|
    t.string "first_name", null: false
    t.string "last_name", null: false
    t.string "email", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "countries", force: :cascade do |t|
    t.string "code", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_countries_on_code", unique: true
  end

  create_table "currencies", force: :cascade do |t|
    t.string "code", limit: 3, null: false
    t.string "symbol", limit: 3, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_currencies_on_code", unique: true
  end

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer "priority", default: 0, null: false
    t.integer "attempts", default: 0, null: false
    t.text "handler", null: false
    t.text "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string "locked_by"
    t.string "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.index ["priority", "run_at"], name: "delayed_jobs_priority"
  end

  create_table "languages", force: :cascade do |t|
    t.string "code", limit: 2, null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["code"], name: "index_languages_on_code", unique: true
  end

  create_table "legal_entity_types", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name", null: false
    t.integer "user_id"
    t.integer "address_id"
    t.integer "contact_id"
    t.string "vat_number", null: false
    t.string "tax_office", null: false
    t.string "website"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "size"
    t.index ["address_id"], name: "index_organizations_on_address_id"
    t.index ["contact_id"], name: "index_organizations_on_contact_id"
    t.index ["user_id"], name: "index_organizations_on_user_id"
  end

  create_table "product_categories", force: :cascade do |t|
    t.string "name", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "product_families", force: :cascade do |t|
    t.string "name", null: false
    t.integer "product_category_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_category_id"], name: "index_product_families_on_product_category_id"
  end

  create_table "product_varieties", force: :cascade do |t|
    t.string "name", null: false
    t.integer "product_family_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["product_family_id"], name: "index_product_varieties_on_product_family_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", null: false
    t.string "encrypted_password", limit: 128, null: false
    t.string "email_confirmation_token", limit: 128
    t.datetime "email_confirmation_requested_at"
    t.datetime "email_confirmed_at"
    t.string "password_change_token", limit: 128
    t.datetime "password_change_requested_at"
    t.datetime "password_changed_at"
    t.string "gender"
    t.datetime "birth_date"
    t.string "time_zone", default: "UTC", null: false
    t.boolean "receive_email_notifications", default: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.integer "country_id"
    t.integer "currency_id"
    t.integer "language_id"
    t.index ["country_id"], name: "index_users_on_country_id"
    t.index ["currency_id"], name: "index_users_on_currency_id"
    t.index ["email"], name: "index_users_on_email"
    t.index ["language_id"], name: "index_users_on_language_id"
  end

end
