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

ActiveRecord::Schema.define(version: 20140821060256) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "active_admin_comments", force: true do |t|
    t.string   "namespace"
    t.text     "body"
    t.string   "resource_id",   null: false
    t.string   "resource_type", null: false
    t.integer  "author_id"
    t.string   "author_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "active_admin_comments", ["author_type", "author_id"], name: "index_active_admin_comments_on_author_type_and_author_id", using: :btree
  add_index "active_admin_comments", ["namespace"], name: "index_active_admin_comments_on_namespace", using: :btree
  add_index "active_admin_comments", ["resource_type", "resource_id"], name: "index_active_admin_comments_on_resource_type_and_resource_id", using: :btree

  create_table "activities", force: true do |t|
    t.integer  "trackable_id"
    t.string   "trackable_type"
    t.integer  "owner_id"
    t.string   "owner_type"
    t.string   "key"
    t.text     "parameters"
    t.integer  "recipient_id"
    t.string   "recipient_type"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "activities", ["owner_id", "owner_type"], name: "index_activities_on_owner_id_and_owner_type", using: :btree
  add_index "activities", ["recipient_id", "recipient_type"], name: "index_activities_on_recipient_id_and_recipient_type", using: :btree
  add_index "activities", ["trackable_id", "trackable_type"], name: "index_activities_on_trackable_id_and_trackable_type", using: :btree

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
    t.integer "payment_plan_id"
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

  create_table "notifications", force: true do |t|
    t.integer  "event_id"
    t.string   "event_type"
    t.integer  "user_id"
    t.datetime "created_at"
    t.datetime "updated_at"
  end

  add_index "notifications", ["user_id"], name: "index_notifications_on_user_id", using: :btree

  create_table "payment_plans", force: true do |t|
    t.integer  "total_due"
    t.integer  "num_payments"
    t.datetime "due_date"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.boolean  "trashed",    default: false
  end

  create_table "stage_change_events", force: true do |t|
    t.integer  "box_history_id"
    t.datetime "created_at"
    t.datetime "updated_at"
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
    t.integer  "standard_payment_plan_id"
    t.boolean  "payment"
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
    t.string   "uid"
    t.string   "encrypted_password",     default: "", null: false
    t.string   "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer  "sign_in_count",          default: 0,  null: false
    t.datetime "current_sign_in_at"
    t.datetime "last_sign_in_at"
    t.string   "current_sign_in_ip"
    t.string   "last_sign_in_ip"
  end

  add_index "users", ["email"], name: "index_users_on_email", unique: true, using: :btree
  add_index "users", ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true, using: :btree

end
