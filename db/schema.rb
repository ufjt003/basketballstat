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

ActiveRecord::Schema.define(version: 20140220163613) do

  create_table "player_stats", force: true do |t|
    t.integer  "field_goal_attempted",    default: 0, null: false
    t.integer  "field_goal_made",         default: 0, null: false
    t.integer  "three_pointer_attempted", default: 0, null: false
    t.integer  "three_pointer_made",      default: 0, null: false
    t.integer  "player_id"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "free_throw_attempted",    default: 0, null: false
    t.integer  "free_throw_made",         default: 0, null: false
    t.integer  "assist",                  default: 0, null: false
    t.integer  "rebound",                 default: 0, null: false
    t.integer  "steal",                   default: 0, null: false
    t.integer  "block",                   default: 0, null: false
    t.integer  "turnover",                default: 0, null: false
  end

  create_table "players", force: true do |t|
    t.string   "name",       default: "", null: false
    t.integer  "number"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "team_id"
  end

  create_table "team_stats", force: true do |t|
    t.integer  "field_goal_attempted",    default: 0, null: false
    t.integer  "field_goal_made",         default: 0, null: false
    t.integer  "three_pointer_attempted", default: 0, null: false
    t.integer  "three_pointer_made",      default: 0, null: false
    t.integer  "free_throw_attempted",    default: 0, null: false
    t.integer  "free_throw_made",         default: 0, null: false
    t.integer  "assist",                  default: 0, null: false
    t.integer  "rebound",                 default: 0, null: false
    t.integer  "steal",                   default: 0, null: false
    t.integer  "block",                   default: 0, null: false
    t.integer  "turnover",                default: 0, null: false
    t.integer  "team_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "teams", force: true do |t|
    t.string   "name",       default: "", null: false
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "users", force: true do |t|
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
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "name",                   default: "", null: false
    t.integer  "number"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true

end