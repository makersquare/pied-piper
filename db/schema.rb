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

ActiveRecord::Schema.define(version: 20140807234645) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "box_fields", force: true do |t|
    t.integer "field_id"
    t.integer "box_id"
    t.string  "value"
  end

  create_table "box_histories", force: true do |t|
    t.integer  "box_id"
    t.integer  "stage_id"
    t.integer  "stage_from"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "boxes", force: true do |t|
    t.integer "contact_id"
    t.integer "stage_id"
    t.integer "pipeline_id"
    t.integer "pipeline_location"
  end

  create_table "contacts", force: true do |t|
    t.string "name"
    t.string "email"
    t.string "city"
    t.string "phonenumber"
  end

  create_table "email_settings", force: true do |t|
    t.string   "setting",          default: "Realtime"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.integer  "pipeline_user_id"
  end

  create_table "fields", force: true do |t|
    t.string  "field_name"
    t.string  "field_type"
    t.integer "pipeline_id"
  end

  create_table "notes", force: true do |t|
    t.integer "user_id"
    t.integer "box_id"
    t.text    "notes"
  end

  create_table "pipeline_users", force: true do |t|
    t.integer  "user_id"
    t.integer  "pipeline_id"
    t.boolean  "admin"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "pipelines", force: true do |t|
    t.string   "name"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.boolean  "trashed"
  end

  create_table "stage_fields", force: true do |t|
    t.integer "stage_id"
    t.integer "field_id"
    t.boolean "visible"
  end

  create_table "stages", force: true do |t|
    t.string   "name"
    t.text     "description"
    t.integer  "pipeline_id"
    t.integer  "pipeline_location"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  create_table "user_stages", force: true do |t|
    t.integer "user_id"
    t.integer "stage_id"
    t.boolean "hidden"
  end

  create_table "users", force: true do |t|
    t.string   "name"
    t.string   "email"
    t.datetime "created_at"
    t.datetime "updated_at"
    t.string   "provider"
    t.string   "oauth_token"
    t.datetime "oauth_expires_at"
    t.string   "webhook_id"
  end

end
