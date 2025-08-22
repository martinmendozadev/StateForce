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

ActiveRecord::Schema[8.0].define(version: 2025_08_22_065644) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "event_category", ["animal_rescue", "bomb_threat", "emergency", "epidemic_response", "evacuation", "fire_incident", "flood_response", "hazardous_material", "infrastructure_collapse", "medical_emergency", "missing_person", "natural_disaster", "operative", "other", "power_outage", "public_disturbance", "rescue_operation", "simulacrum", "support_request", "traffic_accident", "training", "unknown"]
  create_enum "event_status", ["assigned", "arrived", "cancelled", "closed", "en_route", "on_scene", "pending", "resolved"]
  create_enum "file_type", ["certification", "document", "image", "other", "video"]
  create_enum "gender", ["female", "intersex", "male", "other"]
  create_enum "phone_type", ["home", "landline", "mobile", "office", "other", "personal", "unknown"]
  create_enum "priority_level", ["critical", "high", "low", "medium", "unknown"]
  create_enum "recurrence_rule", ["once", "daily", "weekly", "monthly", "yearly"]
  create_enum "resource_status", ["available", "maintenance", "out_of_service", "unknown"]
  create_enum "role", ["admin", "guest", "manager", "restricted", "standard", "superadmin"]
  create_enum "sector_type", ["public", "private", "social", "unknown"]
  create_enum "status_invite", ["active", "accepted", "cancelled", "done", "draft", "expired", "paused", "pending", "retired", "revoked", "sent", "unknown"]
  create_enum "triage_status", ["black", "green", "red", "unknown", "yellow"]
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

  create_table "contacts", force: :cascade do |t|
    t.string "email", limit: 150
    t.string "name", limit: 50
    t.string "radio_frequency", limit: 75
    t.integer "channel", limit: 2
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["email"], name: "index_contacts_on_email", unique: true
  end

  create_table "events", force: :cascade do |t|
    t.text "description"
    t.datetime "ended_at", precision: nil
    t.enum "event_type", default: "emergency", null: false, enum_type: "event_category"
    t.string "event_code", limit: 50
    t.enum "priority_level", default: "unknown", null: false, enum_type: "priority_level"
    t.integer "people_affected", limit: 2, default: 0
    t.string "reported_by_text", limit: 150
    t.datetime "reported_time", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.enum "status", default: "pending", null: false, enum_type: "event_status"
    t.bigint "location_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["event_code"], name: "index_events_on_event_code", unique: true
    t.index ["location_id"], name: "index_events_on_location_id"
  end

  create_table "institutions", force: :cascade do |t|
    t.string "callsign", limit: 50
    t.text "description"
    t.string "name", limit: 150, null: false
    t.enum "sector_type", default: "unknown", null: false, enum_type: "sector_type"
    t.enum "status", default: "unknown", null: false, enum_type: "resource_status"
    t.bigint "director_id"
    t.bigint "location_id", null: false
    t.bigint "parent_institution_id"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["callsign"], name: "index_institutions_on_callsign", unique: true
    t.index ["director_id"], name: "index_institutions_on_director_id"
    t.index ["location_id"], name: "index_institutions_on_location_id"
    t.index ["name"], name: "index_institutions_on_name", unique: true
    t.index ["parent_institution_id"], name: "index_institutions_on_parent_institution_id"
  end

  create_table "invites", force: :cascade do |t|
    t.string "email", limit: 150
    t.datetime "expires_at", null: false
    t.enum "role", null: false, enum_type: "role"
    t.enum "status", default: "draft", null: false, enum_type: "status_invite"
    t.string "token", null: false
    t.datetime "used_at"
    t.bigint "inviter_id"
    t.bigint "institution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["institution_id"], name: "index_invites_on_institution_id"
    t.index ["token"], name: "index_invites_on_token", unique: true
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

  create_table "patient_vitals", force: :cascade do |t|
    t.integer "blood_pressure_systolic", limit: 2
    t.integer "blood_pressure_diastolic", limit: 2
    t.integer "capillary_blood_glucose", limit: 2
    t.jsonb "glasgow_coma_score"
    t.integer "heart_rate", limit: 2
    t.integer "oxygen_saturation", limit: 2
    t.datetime "recorded_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.integer "respiratory_rate", limit: 2
    t.decimal "temperature", precision: 4, scale: 1
    t.bigint "patient_id", null: false
    t.bigint "recorded_by_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["patient_id"], name: "index_patient_vitals_on_patient_id"
    t.index ["recorded_by_user_id"], name: "index_patient_vitals_on_recorded_by_user_id"
  end

  create_table "patients", force: :cascade do |t|
    t.string "name", limit: 100, null: false
    t.integer "age", limit: 2, null: false
    t.enum "gender", default: "other", null: false, enum_type: "gender"
    t.enum "triage_status", default: "unknown", null: false, enum_type: "triage_status"
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["event_id"], name: "index_patients_on_event_id"
  end

  create_table "phone_numbers", force: :cascade do |t|
    t.string "extension", limit: 3
    t.string "number", limit: 25
    t.enum "phone_type", default: "personal", null: false, enum_type: "phone_type"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
  end

  create_table "resource_categories", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["name"], name: "index_resource_categories_on_name", unique: true
  end

  create_table "resource_types", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.text "description"
    t.bigint "resource_category_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["name", "resource_category_id"], name: "index_resource_types_on_name_and_resource_category_id", unique: true
    t.index ["resource_category_id"], name: "index_resource_types_on_resource_category_id"
  end

  create_table "resources", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.text "description"
    t.integer "available_units", default: 0, null: false
    t.integer "total_units", default: 0, null: false
    t.string "units_identifier", limit: 50
    t.bigint "icon_id"
    t.bigint "institution_id", null: false
    t.bigint "location_id", null: false
    t.bigint "resource_type_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["icon_id"], name: "index_resources_on_icon_id"
    t.index ["institution_id"], name: "index_resources_on_institution_id"
    t.index ["location_id"], name: "index_resources_on_location_id"
    t.index ["name", "institution_id"], name: "index_resources_on_name_and_institution_id", unique: true
    t.index ["resource_type_id"], name: "index_resources_on_resource_type_id"
  end

  create_table "schedule_entries", force: :cascade do |t|
    t.string "title", limit: 100
    t.text "description"
    t.interval "duration"
    t.datetime "ends_at"
    t.datetime "estimated_ends_at"
    t.enum "priority_level", default: "unknown", null: false, enum_type: "priority_level"
    t.enum "recurrence_rule", default: "once", null: false, enum_type: "recurrence_rule"
    t.datetime "repeat_until"
    t.datetime "scheduled_at"
    t.enum "status", default: "pending", null: false, enum_type: "event_status"
    t.enum "visibility", default: "private", null: false, enum_type: "visibility"
    t.bigint "creator_user_id", null: false
    t.bigint "event_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["creator_user_id"], name: "index_schedule_entries_on_creator_user_id"
    t.index ["event_id"], name: "index_schedule_entries_on_event_id"
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
  add_foreign_key "events", "locations"
  add_foreign_key "institutions", "institutions", column: "parent_institution_id"
  add_foreign_key "institutions", "locations"
  add_foreign_key "institutions", "users", column: "director_id"
  add_foreign_key "invites", "institutions"
  add_foreign_key "invites", "users", column: "inviter_id"
  add_foreign_key "notes", "users", column: "creator_user_id"
  add_foreign_key "patient_vitals", "patients"
  add_foreign_key "patient_vitals", "users", column: "recorded_by_user_id"
  add_foreign_key "patients", "events"
  add_foreign_key "resource_types", "resource_categories"
  add_foreign_key "resources", "attachments", column: "icon_id"
  add_foreign_key "resources", "institutions"
  add_foreign_key "resources", "locations"
  add_foreign_key "resources", "resource_types"
  add_foreign_key "schedule_entries", "events"
  add_foreign_key "schedule_entries", "users", column: "creator_user_id"
  add_foreign_key "users", "attachments", column: "avatar_id"
end
