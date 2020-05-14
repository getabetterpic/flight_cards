# This file is auto-generated from the current state of the database. Instead
# of editing this file, please use the migrations feature of Active Record to
# incrementally modify your database, and then regenerate this schema definition.
#
# This file is the source Rails uses to define your schema when running `rails
# db:schema:load`. When creating a new database, `rails db:schema:load` tends to
# be faster and is potentially less error prone than running all of your
# migrations from scratch. Old migrations may fail to apply correctly if those
# migrations use external dependencies or application code.
#
# It's strongly recommended that you check this file into your version control system.

ActiveRecord::Schema.define(version: 2020_05_14_121948) do

  create_table "flight_cards", force: :cascade do |t|
    t.string "name", null: false
    t.json "memberships", default: {}
    t.string "rocket_name", default: ""
    t.string "rocket_manufacturer", default: ""
    t.string "rocket_type"
    t.integer "stages", default: 1
    t.integer "cluster", default: 1
    t.string "launch_guide"
    t.string "motor_manufacturer"
    t.string "motor"
    t.json "recovery", default: {}
    t.text "chute_release"
    t.json "flight_info", default: {}
    t.boolean "rso_approved", default: false
    t.string "pad_assignment"
    t.boolean "flown", default: false
    t.integer "user_id"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.integer "launch_id"
    t.index ["launch_id"], name: "index_flight_cards_on_launch_id"
    t.index ["user_id"], name: "index_flight_cards_on_user_id"
  end

  create_table "launches", force: :cascade do |t|
    t.datetime "date"
    t.string "location"
    t.string "name", null: false
    t.integer "admin_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "rso_digest"
    t.string "lco_digest"
    t.index ["admin_id"], name: "index_launches_on_admin_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "role", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

end
