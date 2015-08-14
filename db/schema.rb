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

ActiveRecord::Schema.define(version: 20150814085842) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "countries", force: :cascade do |t|
    t.string   "code",       limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "countries", ["code"], name: "index_countries_on_code", unique: true, using: :btree

  create_table "currencies", force: :cascade do |t|
    t.string   "code",       limit: 3, null: false
    t.string   "symbol",     limit: 3, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "currencies", ["code"], name: "index_currencies_on_code", unique: true, using: :btree

  create_table "delayed_jobs", force: :cascade do |t|
    t.integer  "priority",   default: 0, null: false
    t.integer  "attempts",   default: 0, null: false
    t.text     "handler",                null: false
    t.text     "last_error"
    t.datetime "run_at"
    t.datetime "locked_at"
    t.datetime "failed_at"
    t.string   "locked_by"
    t.string   "queue"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "delayed_jobs", ["priority", "run_at"], name: "delayed_jobs_priority", using: :btree

  create_table "languages", force: :cascade do |t|
    t.string   "code",       limit: 2, null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "languages", ["code"], name: "index_languages_on_code", unique: true, using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                                                       null: false
    t.string   "encrypted_password",              limit: 128,                 null: false
    t.string   "email_confirmation_token",        limit: 128
    t.datetime "email_confirmation_requested_at"
    t.datetime "email_confirmed_at"
    t.string   "password_change_token",           limit: 128
    t.datetime "password_change_requested_at"
    t.datetime "password_changed_at"
    t.datetime "created_at",                                                  null: false
    t.datetime "updated_at",                                                  null: false
    t.string   "full_name"
    t.boolean  "receive_email_notifications",                 default: false
    t.string   "time_zone",                                   default: "UTC"
    t.datetime "birth_date"
    t.string   "gender"
    t.integer  "country_id"
    t.integer  "currency_id"
    t.integer  "language_id"
  end

  add_index "users", ["email"], name: "index_users_on_email", using: :btree

end
