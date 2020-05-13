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

ActiveRecord::Schema.define(version: 20200513024405) do

  # These are extensions that must be enabled in order to support this database
  enable_extension "plpgsql"

  create_table "apps", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
    t.string "phone_number"
    t.string "description"
  end

  create_table "pet_apps", force: :cascade do |t|
    t.bigint "pet_id"
    t.bigint "app_id"
    t.index ["app_id"], name: "index_pet_apps_on_app_id"
    t.index ["pet_id"], name: "index_pet_apps_on_pet_id"
  end

  create_table "pets", force: :cascade do |t|
    t.string "image"
    t.text "description"
    t.boolean "adoptable"
    t.string "name"
    t.string "age"
    t.string "sex"
    t.bigint "shelter_id"
    t.index ["shelter_id"], name: "index_pets_on_shelter_id"
  end

  create_table "shelters", force: :cascade do |t|
    t.string "name"
    t.string "address"
    t.string "city"
    t.string "state"
    t.string "zip"
  end

  add_foreign_key "pet_apps", "apps"
  add_foreign_key "pet_apps", "pets"
  add_foreign_key "pets", "shelters"
end
