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

ActiveRecord::Schema.define(version: 20160731200539) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "date_time"
    t.date     "date"
    t.time     "time"
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.string   "aasm_state"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "start"
    t.datetime "end"
  end

  add_index "appointments", ["doctor_id"], name: "index_appointments_on_doctor_id", using: :btree
  add_index "appointments", ["user_id"], name: "index_appointments_on_user_id", using: :btree

  create_table "approvals", force: :cascade do |t|
    t.boolean  "approved",   default: false
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.datetime "created_at",                 null: false
    t.datetime "updated_at",                 null: false
    t.string   "aasm_state"
  end

  add_index "approvals", ["doctor_id"], name: "index_approvals_on_doctor_id", using: :btree
  add_index "approvals", ["user_id"], name: "index_approvals_on_user_id", using: :btree

  create_table "comments", force: :cascade do |t|
    t.text     "body"
    t.integer  "rating"
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "comments", ["doctor_id"], name: "index_comments_on_doctor_id", using: :btree
  add_index "comments", ["user_id"], name: "index_comments_on_user_id", using: :btree

  create_table "doctors", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.text     "information"
    t.string   "location"
    t.string   "average_rating"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "doctors", ["first_name", "last_name"], name: "index_doctors_on_first_name_and_last_name", unique: true, using: :btree

  create_table "relation_approvals", force: :cascade do |t|
    t.boolean  "approved"
    t.integer  "user_id"
    t.integer  "doctor_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  add_index "relation_approvals", ["doctor_id"], name: "index_relation_approvals_on_doctor_id", using: :btree
  add_index "relation_approvals", ["user_id"], name: "index_relation_approvals_on_user_id", using: :btree

  create_table "specializations", force: :cascade do |t|
    t.string   "title"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "tagging_specializations", force: :cascade do |t|
    t.integer  "specialization_id"
    t.integer  "doctor_id"
    t.datetime "created_at",        null: false
    t.datetime "updated_at",        null: false
  end

  add_index "tagging_specializations", ["doctor_id"], name: "index_tagging_specializations_on_doctor_id", using: :btree
  add_index "tagging_specializations", ["specialization_id"], name: "index_tagging_specializations_on_specialization_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "first_name"
    t.string   "last_name"
    t.string   "email"
    t.string   "password_digest"
    t.datetime "created_at",      null: false
    t.datetime "updated_at",      null: false
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree

  add_foreign_key "appointments", "doctors"
  add_foreign_key "appointments", "users"
  add_foreign_key "approvals", "doctors"
  add_foreign_key "approvals", "users"
  add_foreign_key "comments", "doctors"
  add_foreign_key "comments", "users"
  add_foreign_key "relation_approvals", "doctors"
  add_foreign_key "relation_approvals", "users"
  add_foreign_key "tagging_specializations", "doctors"
  add_foreign_key "tagging_specializations", "specializations"
end
