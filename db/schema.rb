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

ActiveRecord::Schema.define(version: 2022_05_21_012230) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "appointments", force: :cascade do |t|
    t.datetime "date_time"
    t.bigint "user_id", null: false
    t.bigint "blood_request_id", null: false
    t.boolean "is_completed", default: false
    t.integer "status", default: 1
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["blood_request_id"], name: "index_appointments_on_blood_request_id"
    t.index ["user_id"], name: "index_appointments_on_user_id"
  end

  create_table "blood_requests", force: :cascade do |t|
    t.string "code"
    t.datetime "date_time"
    t.bigint "user_id", null: false
    t.bigint "case_id", null: false
    t.bigint "organization_id", null: false
    t.bigint "request_type_id", null: false
    t.bigint "blood_type_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.boolean "is_closed", default: false
    t.integer "status", default: 1, null: false
    t.index ["blood_type_id"], name: "index_blood_requests_on_blood_type_id"
    t.index ["case_id"], name: "index_blood_requests_on_case_id"
    t.index ["organization_id"], name: "index_blood_requests_on_organization_id"
    t.index ["request_type_id"], name: "index_blood_requests_on_request_type_id"
    t.index ["user_id"], name: "index_blood_requests_on_user_id"
  end

  create_table "blood_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "cases", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "city_municipalities", force: :cascade do |t|
    t.string "name"
    t.bigint "province_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.float "latitude"
    t.float "longitude"
    t.index ["province_id"], name: "index_city_municipalities_on_province_id"
  end

  create_table "donations", force: :cascade do |t|
    t.datetime "harvest_date"
    t.bigint "appointment_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.index ["appointment_id"], name: "index_donations_on_appointment_id"
  end

  create_table "jwt_denylist", force: :cascade do |t|
    t.string "jti", null: false
    t.datetime "exp", null: false
    t.index ["jti"], name: "index_jwt_denylist_on_jti"
  end

  create_table "organization_types", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "organizations", force: :cascade do |t|
    t.string "name"
    t.text "address"
    t.bigint "city_municipality_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "organization_type_id", null: false
    t.index ["city_municipality_id"], name: "index_organizations_on_city_municipality_id"
    t.index ["organization_type_id"], name: "index_organizations_on_organization_type_id"
  end

  create_table "provinces", force: :cascade do |t|
    t.string "name"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "request_types", force: :cascade do |t|
    t.string "name"
    t.text "description"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
  end

  create_table "users", force: :cascade do |t|
    t.string "password"
    t.string "firstname"
    t.string "middlename"
    t.string "lastname"
    t.date "birthday"
    t.text "address"
    t.integer "availability_status"
    t.string "mobile_no"
    t.integer "blood_type_id"
    t.float "longitude"
    t.float "latitude"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.integer "role"
    t.bigint "city_municipality_id"
    t.bigint "organization_id"
    t.index ["blood_type_id"], name: "index_users_on_blood_type_id"
    t.index ["city_municipality_id"], name: "index_users_on_city_municipality_id"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["organization_id"], name: "index_users_on_organization_id"
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "appointments", "blood_requests"
  add_foreign_key "appointments", "users"
  add_foreign_key "blood_requests", "blood_types"
  add_foreign_key "blood_requests", "cases"
  add_foreign_key "blood_requests", "organizations"
  add_foreign_key "blood_requests", "request_types"
  add_foreign_key "blood_requests", "users"
  add_foreign_key "city_municipalities", "provinces"
  add_foreign_key "donations", "appointments"
  add_foreign_key "organizations", "city_municipalities"
  add_foreign_key "organizations", "organization_types"
  add_foreign_key "users", "blood_types"
  add_foreign_key "users", "city_municipalities"
  add_foreign_key "users", "organizations"
end
