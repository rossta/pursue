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

ActiveRecord::Schema.define(version: 20150130122629) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "entries", force: :cascade do |t|
    t.string   "summary",          limit: 255
    t.text     "notes"
    t.integer  "day"
    t.integer  "week"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "distance",                     default: "0 m"
    t.string   "duration",                     default: "0 s"
    t.date     "occurs_on"
    t.integer  "schedulable_id"
    t.string   "schedulable_type"
  end

  add_index "entries", ["schedulable_type", "schedulable_id"], name: "index_entries_on_schedulable_type_and_schedulable_id", using: :btree

  create_table "events", force: :cascade do |t|
    t.string   "title",      limit: 255
    t.date     "occurs_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "oauth_accounts", force: :cascade do |t|
    t.integer "user_id"
    t.string  "provider"
    t.string  "uid"
    t.string  "name"
    t.string  "first_name"
    t.string  "last_name"
    t.string  "email"
    t.string  "location"
    t.string  "token"
  end

  add_index "oauth_accounts", ["user_id"], name: "index_oauth_accounts_on_user_id", using: :btree

  create_table "schedules", force: :cascade do |t|
    t.string   "title",            limit: 255
    t.integer  "training_plan_id"
    t.integer  "event_id"
    t.integer  "owner_id"
    t.date     "peaks_on"
    t.date     "starts_on"
    t.date     "ends_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "schedules", ["event_id"], name: "index_schedules_on_event_id", using: :btree
  add_index "schedules", ["owner_id"], name: "index_schedules_on_owner_id", using: :btree
  add_index "schedules", ["training_plan_id"], name: "index_schedules_on_training_plan_id", using: :btree

  create_table "taggings", force: :cascade do |t|
    t.integer  "tag_id"
    t.string   "tag_type",      limit: 255
    t.integer  "taggable_id"
    t.string   "taggable_type", limit: 255
    t.integer  "tagger_id"
    t.string   "tagger_type",   limit: 255
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "tag_type"], name: "index_taggings_on_tag_id_and_tag_type", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree

  create_table "tags", force: :cascade do |t|
    t.string "name", limit: 255
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "training_plans", force: :cascade do |t|
    t.string   "title",        limit: 255, null: false
    t.string   "summary",      limit: 255
    t.integer  "creator_id",               null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_weeks"
    t.integer  "peak_week"
    t.string   "thumbnail_id"
  end

  add_index "training_plans", ["creator_id"], name: "index_training_plans_on_creator_id", using: :btree

  create_table "users", force: :cascade do |t|
    t.string   "email",                  limit: 255, default: "", null: false
    t.string   "encrypted_password",     limit: 255, default: "", null: false
    t.string   "reset_password_token",   limit: 255
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",                      default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.inet     "current_sign_in_ip"
    t.inet     "last_sign_in_ip"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name",             limit: 255
    t.string   "last_name",              limit: 255
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  add_foreign_key "oauth_accounts", "users"
end
