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

ActiveRecord::Schema.define(version: 20140908114729) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "events", force: true do |t|
    t.string   "title"
    t.date     "occurs_on"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "schedules", force: true do |t|
    t.string   "title"
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

  create_table "taggings", force: true do |t|
    t.integer  "tag_id"
    t.string   "tag_type"
    t.integer  "taggable_id"
    t.string   "taggable_type"
    t.integer  "tagger_id"
    t.string   "tagger_type"
    t.string   "context",       limit: 128
    t.datetime "created_at"
  end

  add_index "taggings", ["tag_id", "tag_type"], name: "index_taggings_on_tag_id_and_tag_type", using: :btree
  add_index "taggings", ["tag_id", "taggable_id", "taggable_type", "context", "tagger_id", "tagger_type"], name: "taggings_idx", unique: true, using: :btree
  add_index "taggings", ["taggable_id", "taggable_type", "context"], name: "index_taggings_on_taggable_id_and_taggable_type_and_context", using: :btree
  add_index "taggings", ["taggable_id", "taggable_type"], name: "index_taggings_on_taggable_id_and_taggable_type", using: :btree
  add_index "taggings", ["tagger_id", "tagger_type"], name: "index_taggings_on_tagger_id_and_tagger_type", using: :btree

  create_table "tags", force: true do |t|
    t.string "name"
  end

  add_index "tags", ["name"], name: "index_tags_on_name", unique: true, using: :btree

  create_table "training_plans", force: true do |t|
    t.string   "title",       null: false
    t.string   "summary"
    t.integer  "creator_id",  null: false
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "total_weeks"
    t.integer  "peak_week"
  end

  add_index "training_plans", ["creator_id"], name: "index_training_plans_on_creator_id", using: :btree

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "first_name"
    t.string   "last_name"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

  create_table "workout_plans", force: true do |t|
    t.string   "summary"
    t.text     "notes"
    t.integer  "day"
    t.integer  "week"
    t.integer  "training_plan_id", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "workout_plans", ["training_plan_id"], name: "index_workout_plans_on_training_plan_id", using: :btree

end
