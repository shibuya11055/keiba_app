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

ActiveRecord::Schema.define(version: 2021_03_07_161631) do

  create_table "horses", force: :cascade do |t|
    t.string "name", limit: 10, null: false
    t.integer "gender", null: false
    t.date "birthday"
    t.integer "traner_id", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "jockeys", force: :cascade do |t|
    t.string "name", null: false
    t.date "birthday"
    t.integer "registration_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "race_horses", force: :cascade do |t|
    t.integer "horse_id"
    t.integer "race_id"
    t.integer "jockey_id"
    t.integer "ranking"
    t.integer "post_position"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
    t.index ["horse_id"], name: "index_race_horses_on_horse_id"
    t.index ["jockey_id"], name: "index_race_horses_on_jockey_id"
    t.index ["race_id"], name: "index_race_horses_on_race_id"
  end

  create_table "races", force: :cascade do |t|
    t.string "name", null: false
    t.date "event_date", null: false
    t.integer "track_id", null: false
    t.integer "grade", null: false
    t.integer "is_finish", default: 0, null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "tracks", force: :cascade do |t|
    t.string "name", null: false
    t.integer "field_type", default: 0, null: false
    t.integer "field_range", null: false
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  create_table "traners", force: :cascade do |t|
    t.string "name", null: false
    t.date "birthday"
    t.integer "registration_number"
    t.datetime "created_at", precision: 6, null: false
    t.datetime "updated_at", precision: 6, null: false
    t.datetime "deleted_at"
  end

  add_foreign_key "race_horses", "horses"
  add_foreign_key "race_horses", "jockeys"
  add_foreign_key "race_horses", "races"
end
