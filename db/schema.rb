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

ActiveRecord::Schema[8.0].define(version: 2025_08_05_073028) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "file_type", ["certification", "document", "image", "other", "video"]
  create_enum "visibility", ["public", "private", "restricted"]

  create_table "attachments", force: :cascade do |t|
    t.string "content_type", limit: 25
    t.text "description"
    t.string "file_name", limit: 75
    t.bigint "file_size"
    t.enum "file_type", default: "other", null: false, enum_type: "file_type"
    t.string "file_url", null: false
    t.enum "visibility", default: "private", null: false, enum_type: "visibility"
    t.bigint "uploader_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["uploader_user_id"], name: "index_attachments_on_uploader_user_id"
  end

  create_table "locations", force: :cascade do |t|
    t.string "address", limit: 150
    t.text "key_name"
    t.string "place_name", limit: 100
    t.geography "coordinates", limit: {srid: 4326, type: "st_point", geographic: true}
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "notes", force: :cascade do |t|
    t.string "title", limit: 100, null: false
    t.text "body", null: false
    t.enum "visibility", default: "private", null: false, enum_type: "visibility"
    t.bigint "creator_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["creator_user_id"], name: "index_notes_on_creator_user_id"
  end

  create_table "users", force: :cascade do |t|
    t.string "email", limit: 150, default: "", null: false
    t.string "encrypted_password", default: "", null: false
    t.string "reset_password_token"
    t.datetime "reset_password_sent_at"
    t.datetime "remember_created_at"
    t.string "confirmation_token"
    t.datetime "confirmed_at"
    t.datetime "confirmation_sent_at"
    t.string "unconfirmed_email"
    t.string "name", limit: 75
    t.boolean "active", default: true
    t.string "uid"
    t.integer "provider", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.bigint "avatar_id"
    t.index ["avatar_id"], name: "index_users_on_avatar_id"
    t.index ["confirmation_token"], name: "index_users_on_confirmation_token", unique: true
    t.index ["email"], name: "index_users_on_email", unique: true
    t.index ["reset_password_token"], name: "index_users_on_reset_password_token", unique: true
    t.index ["uid"], name: "index_users_on_uid"
  end

  add_foreign_key "attachments", "users", column: "uploader_user_id"
  add_foreign_key "notes", "users", column: "creator_user_id"
  add_foreign_key "users", "attachments", column: "avatar_id"
end
