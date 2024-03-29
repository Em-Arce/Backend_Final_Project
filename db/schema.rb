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

ActiveRecord::Schema.define(version: 2021_09_20_122224) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "abstracts", force: :cascade do |t|
    t.string "title"
    t.string "main_author"
    t.text "body"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.jsonb "co_authors", default: "{}"
    t.text "co_authors1", default: [], array: true
    t.string "corresponding_author_email", default: "", null: false
    t.jsonb "keywords"
    t.jsonb "references"
    t.index ["co_authors"], name: "index_abstracts_on_co_authors", using: :gin
  end

  create_table "conferences", force: :cascade do |t|
    t.string "name"
    t.string "string"
    t.integer "year"
    t.string "theme"
    t.string "venue"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "kind"
    t.index ["kind"], name: "index_conferences_on_kind"
  end

  create_table "participations", force: :cascade do |t|
    t.string "fee"
    t.bigint "user_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.bigint "abstract_id", null: false
    t.string "kind"
    t.index ["abstract_id"], name: "index_participations_on_abstract_id"
    t.index ["kind"], name: "index_participations_on_kind"
    t.index ["user_id"], name: "index_participations_on_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "first_name"
    t.string "last_name"
    t.string "prefix"
    t.string "suffix"
    t.string "position"
    t.string "university_institute_company"
    t.string "department"
    t.string "contact_number"
    t.boolean "admin", default: false
    t.boolean "isvsp2022_registered", default: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.string "city"
    t.string "country"
    t.string "position_other"
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
  end

  add_foreign_key "participations", "abstracts"
  add_foreign_key "participations", "users"
end
