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

ActiveRecord::Schema.define(version: 20180108122807) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "affilates", force: :cascade do |t|
    t.string   "address"
    t.string   "name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "phone"
  end

  create_table "clients", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string   "last_name"
    t.string   "name"
    t.string   "patronymic"
    t.string   "email"
    t.string   "phone"
    t.date     "birthdate"
    t.string   "is_moscow"
  end

  create_table "doctors", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.string   "last_name"
    t.string   "name"
    t.string   "patronymic"
    t.string   "rank"
    t.integer  "affilate_id"
    t.index ["affilate_id"], name: "index_doctors_on_affilate_id", using: :btree
  end

  create_table "feedbacks", force: :cascade do |t|
    t.string   "name"
    t.string   "last_name"
    t.string   "patronymic"
    t.string   "email"
    t.string   "theme"
    t.text     "text"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "seances", force: :cascade do |t|
    t.datetime "created_at",  null: false
    t.datetime "updated_at",  null: false
    t.datetime "date"
    t.integer  "doctor_id"
    t.integer  "client_id"
    t.integer  "affilate_id"
    t.index ["affilate_id"], name: "index_seances_on_affilate_id", using: :btree
    t.index ["client_id"], name: "index_seances_on_client_id", using: :btree
    t.index ["doctor_id"], name: "index_seances_on_doctor_id", using: :btree
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
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
    t.datetime "created_at",                          null: false
    t.datetime "updated_at",                          null: false
    t.string   "role"
    t.string   "username"
    t.integer  "affilate_id"
    t.index ["affilate_id"], name: "index_users_on_affilate_id", using: :btree
    t.index ["email"], name: "index_users_on_email", unique: true, using: :btree
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree
  end

end
