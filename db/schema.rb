# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `bin/rails
# db:schema:load`. When creating a new database, `bin/rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema[7.1].define(version: 2025_01_13_202804) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "features", force: :cascade do |t|
    t.string "feature_name"
    t.string "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "jwt_denylists", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["jti"], name: "index_jwt_denylists_on_jti", unique: true
  end

  create_table "profiles", force: :cascade do |t|
    t.string "profile_name"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.index ["profile_name"], name: "index_profiles_on_profile_name"
  end

  create_table "project_users", force: :cascade do |t|
    t.bigint "project_id", null: false
    t.bigint "user_id", null: false
    t.boolean "billing_access"
    t.boolean "timesheet"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "profile_id"
    t.index ["project_id"], name: "index_project_users_on_project_id"
    t.index ["user_id"], name: "index_project_users_on_user_id"
  end

  create_table "projects", force: :cascade do |t|
    t.string "project_name"
    t.decimal "billing_rate", precision: 10, scale: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
  end

  create_table "timesheets", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.float "total_hours", default: 0.0
    t.string "status", default: "pending"
    t.date "week_start_date", null: false
    t.integer "year", default: 0, null: false
    t.bigint "project_user_id"
    t.jsonb "daily_hours", default: {}, null: false
    t.text "description"
    t.index ["project_user_id"], name: "index_timesheets_on_project_user_id"
  end

  create_table "user_features", force: :cascade do |t|
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.bigint "user_id", null: false
    t.bigint "feature_id", null: false
    t.index ["feature_id"], name: "index_user_features_on_feature_id"
    t.index ["user_id"], name: "index_user_features_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "name"
    t.string "email", null: false
    t.string "password"
    t.integer "role"
    t.integer "employee_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.string "jwt_revocation_token"
    t.string "encrypted_password"
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "jti"
    t.index ["jti"], name: "index_users_on_jti", unique: true
  end

  add_foreign_key "project_users", "profiles"
  add_foreign_key "project_users", "projects", on_delete: :cascade
  add_foreign_key "project_users", "users"
  add_foreign_key "timesheets", "project_users"
  add_foreign_key "user_features", "features"
  add_foreign_key "user_features", "users"
end
