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

ActiveRecord::Schema[8.0].define(version: 2025_08_25_060945) do
  # These are extensions that must be enabled in order to support this database
  enable_extension "pg_catalog.plpgsql"
  enable_extension "postgis"

  # Custom types defined in this database.
  # Note that some types may not work with other database engines. Be careful if changing database.
  create_enum "actions", ["created", "deleted", "read", "restored", "updated"]
  create_enum "bed_type", ["emergency", "gynecology", "icu", "internal_medicine", "isolated", "neonatal_icu", "pediatric", "trauma", "general", "maternity"]
  create_enum "contact_type", ["emergency", "primary", "technical_support"]
  create_enum "entity_names", ["contacts", "events", "resources", "user", "patients", "institutions", "attachments", "schedule_entries", "phone_numbers", "invites", "resource_categories", "resource_types", "patient_transfers", "audit_logs", "unknown"]
  create_enum "event_category", ["animal_rescue", "bomb_threat", "emergency", "epidemic_response", "evacuation", "fire_incident", "flood_response", "hazardous_material", "infrastructure_collapse", "medical_emergency", "missing_person", "natural_disaster", "operative", "other", "power_outage", "public_disturbance", "rescue_operation", "simulacrum", "support_request", "traffic_accident", "training", "unknown"]
  create_enum "event_status", ["assigned", "arrived", "cancelled", "closed", "en_route", "on_scene", "pending", "resolved"]
  create_enum "facility_type", ["hospital", "clinic", "rescue_base", "command_center", "other"]
  create_enum "file_type", ["certification", "document", "image", "other", "video"]
  create_enum "gender", ["female", "intersex", "male", "other"]
  create_enum "phone_type", ["home", "landline", "mobile", "office", "other", "personal", "unknown"]
  create_enum "priority_level", ["critical", "high", "low", "medium", "unknown"]
  create_enum "proficiency_level", ["advanced", "basic", "medium", "unknown"]
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

  create_table "audit_logs", force: :cascade do |t|
    t.enum "entity_name", default: "unknown", null: false, enum_type: "entity_names"
    t.enum "action", null: false, enum_type: "actions"
    t.integer "entity_id", null: false
    t.jsonb "new_value", null: false
    t.jsonb "old_value"
    t.bigint "user_id"
    t.datetime "created_at", precision: nil, default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.index ["user_id"], name: "index_audit_logs_on_user_id"
  end

  create_table "bed_inventories", force: :cascade do |t|
    t.integer "available", limit: 2, default: 0, null: false
    t.enum "bed_type", null: false, enum_type: "bed_type"
    t.integer "total", limit: 2, default: 0, null: false
    t.bigint "operational_unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["operational_unit_id"], name: "index_bed_inventories_on_operational_unit_id"
  end

  create_table "competencies", force: :cascade do |t|
    t.enum "level", default: "unknown", null: false, enum_type: "proficiency_level"
    t.bigint "specialty_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["specialty_id"], name: "index_competencies_on_specialty_id"
  end

  create_table "contact_phone_numbers", primary_key: ["contact_id", "phone_number_id"], force: :cascade do |t|
    t.boolean "is_primary", default: false, null: false
    t.bigint "contact_id", null: false
    t.bigint "phone_number_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["contact_id"], name: "index_contact_phone_numbers_on_contact_id"
    t.index ["phone_number_id"], name: "index_contact_phone_numbers_on_phone_number_id"
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

  create_table "event_attachments", primary_key: ["event_id", "attachment_id"], force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "attachment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["attachment_id"], name: "index_event_attachments_on_attachment_id"
    t.index ["event_id"], name: "index_event_attachments_on_event_id"
  end

  create_table "event_institutions", force: :cascade do |t|
    t.datetime "assigned_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "event_id", null: false
    t.bigint "institution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["event_id"], name: "index_event_institutions_on_event_id"
    t.index ["institution_id"], name: "index_event_institutions_on_institution_id"
  end

  create_table "event_notes", primary_key: ["event_id", "note_id"], force: :cascade do |t|
    t.bigint "event_id", null: false
    t.bigint "note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["event_id"], name: "index_event_notes_on_event_id"
    t.index ["note_id"], name: "index_event_notes_on_note_id"
  end

  create_table "event_resources", force: :cascade do |t|
    t.integer "quantity_assigned", default: 1, null: false
    t.datetime "assigned_at", default: -> { "CURRENT_TIMESTAMP" }, null: false
    t.bigint "event_id", null: false
    t.bigint "resource_id", null: false
    t.bigint "assigned_by_user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["assigned_by_user_id"], name: "index_event_resources_on_assigned_by_user_id"
    t.index ["event_id"], name: "index_event_resources_on_event_id"
    t.index ["resource_id"], name: "index_event_resources_on_resource_id"
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

  create_table "institution_attachments", primary_key: ["institution_id", "attachment_id"], force: :cascade do |t|
    t.bigint "institution_id", null: false
    t.bigint "attachment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["attachment_id"], name: "index_institution_attachments_on_attachment_id"
    t.index ["institution_id"], name: "index_institution_attachments_on_institution_id"
  end

  create_table "institution_contacts", force: :cascade do |t|
    t.enum "contact_type", default: "primary", null: false, enum_type: "contact_type"
    t.bigint "institution_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["contact_id"], name: "index_institution_contacts_on_contact_id"
    t.index ["institution_id"], name: "index_institution_contacts_on_institution_id"
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

  create_table "medical_center_profiles", force: :cascade do |t|
    t.boolean "external_pharmacy_available", default: false
    t.boolean "internal_pharmacy_available", default: false
    t.enum "level", default: "unknown", null: false, enum_type: "proficiency_level"
    t.integer "operating_rooms_total", limit: 2, default: 0, null: false
    t.integer "operating_rooms_available", limit: 2, default: 0, null: false
    t.bigint "operational_unit_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["operational_unit_id"], name: "index_medical_center_profiles_on_operational_unit_id"
  end

  create_table "note_editors", primary_key: ["note_id", "user_id"], force: :cascade do |t|
    t.datetime "last_edited_at", precision: nil
    t.bigint "note_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["note_id"], name: "index_note_editors_on_note_id"
    t.index ["user_id"], name: "index_note_editors_on_user_id"
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

  create_table "operational_unit_competencies", primary_key: ["operational_unit_id", "competency_id"], force: :cascade do |t|
    t.bigint "operational_unit_id", null: false
    t.bigint "competency_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["competency_id"], name: "index_operational_unit_competencies_on_competency_id"
    t.index ["operational_unit_id"], name: "index_operational_unit_competencies_on_operational_unit_id"
  end

  create_table "operational_unit_notes", primary_key: ["operational_unit_id", "note_id"], force: :cascade do |t|
    t.bigint "operational_unit_id", null: false
    t.bigint "note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["note_id"], name: "index_operational_unit_notes_on_note_id"
    t.index ["operational_unit_id"], name: "index_operational_unit_notes_on_operational_unit_id"
  end

  create_table "operational_units", force: :cascade do |t|
    t.text "coverage"
    t.string "name", limit: 150, null: false
    t.enum "facility_type", null: false, enum_type: "facility_type"
    t.enum "triage_status", default: "unknown", null: false, enum_type: "triage_status"
    t.bigint "on_charge_shift_user_id"
    t.bigint "parent_institution_id", null: false
    t.bigint "location_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["location_id"], name: "index_operational_units_on_location_id"
    t.index ["on_charge_shift_user_id"], name: "index_operational_units_on_on_charge_shift_user_id"
    t.index ["parent_institution_id"], name: "index_operational_units_on_parent_institution_id"
  end

  create_table "operational_units_attachments", primary_key: ["operational_unit_id", "attachment_id"], force: :cascade do |t|
    t.bigint "operational_unit_id", null: false
    t.bigint "attachment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["attachment_id"], name: "index_operational_units_attachments_on_attachment_id"
    t.index ["operational_unit_id"], name: "index_operational_units_attachments_on_operational_unit_id"
  end

  create_table "patient_transfers", force: :cascade do |t|
    t.datetime "arrival_time", precision: nil
    t.datetime "departure_time", precision: nil
    t.enum "status", default: "pending", null: false, enum_type: "event_status"
    t.bigint "accepted_by_user_id", null: false
    t.bigint "destination_institution_id", null: false
    t.bigint "event_id", null: false
    t.bigint "patient_id", null: false
    t.bigint "requesting_user_id", null: false
    t.bigint "transport_resource_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["accepted_by_user_id"], name: "index_patient_transfers_on_accepted_by_user_id"
    t.index ["destination_institution_id"], name: "index_patient_transfers_on_destination_institution_id"
    t.index ["event_id"], name: "index_patient_transfers_on_event_id"
    t.index ["patient_id"], name: "index_patient_transfers_on_patient_id"
    t.index ["requesting_user_id"], name: "index_patient_transfers_on_requesting_user_id"
    t.index ["transport_resource_id"], name: "index_patient_transfers_on_transport_resource_id"
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

  create_table "resource_attachments", primary_key: ["resource_id", "attachment_id"], force: :cascade do |t|
    t.bigint "resource_id", null: false
    t.bigint "attachment_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["attachment_id"], name: "index_resource_attachments_on_attachment_id"
    t.index ["resource_id"], name: "index_resource_attachments_on_resource_id"
  end

  create_table "resource_categories", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.text "description"
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["name"], name: "index_resource_categories_on_name", unique: true
  end

  create_table "resource_notes", primary_key: ["resource_id", "note_id"], force: :cascade do |t|
    t.bigint "resource_id", null: false
    t.bigint "note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["note_id"], name: "index_resource_notes_on_note_id"
    t.index ["resource_id"], name: "index_resource_notes_on_resource_id"
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

  create_table "schedule_entries_institutions", primary_key: ["schedule_entry_id", "institution_id"], force: :cascade do |t|
    t.bigint "schedule_entry_id", null: false
    t.bigint "institution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["institution_id"], name: "index_schedule_entries_institutions_on_institution_id"
    t.index ["schedule_entry_id"], name: "index_schedule_entries_institutions_on_schedule_entry_id"
  end

  create_table "specialties", force: :cascade do |t|
    t.string "name", limit: 150, null: false
    t.text "description"
    t.string "code", limit: 50
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["code"], name: "index_specialties_on_code", unique: true
    t.index ["name"], name: "index_specialties_on_name", unique: true
  end

  create_table "user_callsigns", force: :cascade do |t|
    t.string "callsign", limit: 50, null: false
    t.bigint "institution_id", null: false
    t.bigint "user_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["callsign", "institution_id"], name: "idx_unique_callsign_per_institution", unique: true
    t.index ["institution_id"], name: "index_user_callsigns_on_institution_id"
    t.index ["user_id"], name: "index_user_callsigns_on_user_id"
  end

  create_table "user_competencies", primary_key: ["user_id", "competency_id"], force: :cascade do |t|
    t.date "expiry_date"
    t.bigint "user_id", null: false
    t.bigint "competency_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["competency_id"], name: "index_user_competencies_on_competency_id"
    t.index ["user_id"], name: "index_user_competencies_on_user_id"
  end

  create_table "user_contacts", primary_key: ["user_id", "contact_id", "contact_type"], force: :cascade do |t|
    t.enum "contact_type", default: "primary", null: false, enum_type: "contact_type"
    t.bigint "user_id", null: false
    t.bigint "contact_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["contact_id"], name: "index_user_contacts_on_contact_id"
    t.index ["user_id"], name: "index_user_contacts_on_user_id"
  end

  create_table "user_institutions", primary_key: ["user_id", "institution_id"], force: :cascade do |t|
    t.string "position", limit: 50, default: "member"
    t.enum "role", default: "guest", null: false, enum_type: "role"
    t.enum "status", default: "draft", null: false, enum_type: "status_invite"
    t.bigint "user_id", null: false
    t.bigint "institution_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["institution_id"], name: "index_user_institutions_on_institution_id"
    t.index ["user_id"], name: "index_user_institutions_on_user_id"
  end

  create_table "user_notes", primary_key: ["user_id", "note_id"], force: :cascade do |t|
    t.boolean "starred", default: false, null: false
    t.bigint "user_id", null: false
    t.bigint "note_id", null: false
    t.datetime "created_at", null: false
    t.datetime "updated_at", null: false
    t.datetime "deleted_at"
    t.index ["note_id"], name: "index_user_notes_on_note_id"
    t.index ["user_id"], name: "index_user_notes_on_user_id"
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
  add_foreign_key "audit_logs", "users"
  add_foreign_key "bed_inventories", "operational_units"
  add_foreign_key "competencies", "specialties"
  add_foreign_key "contact_phone_numbers", "contacts"
  add_foreign_key "contact_phone_numbers", "phone_numbers"
  add_foreign_key "event_attachments", "attachments"
  add_foreign_key "event_attachments", "events"
  add_foreign_key "event_institutions", "events"
  add_foreign_key "event_institutions", "institutions"
  add_foreign_key "event_notes", "events"
  add_foreign_key "event_notes", "notes"
  add_foreign_key "event_resources", "events"
  add_foreign_key "event_resources", "resources"
  add_foreign_key "event_resources", "users", column: "assigned_by_user_id"
  add_foreign_key "events", "locations"
  add_foreign_key "institution_attachments", "attachments"
  add_foreign_key "institution_attachments", "institutions"
  add_foreign_key "institution_contacts", "contacts"
  add_foreign_key "institution_contacts", "institutions"
  add_foreign_key "institutions", "institutions", column: "parent_institution_id"
  add_foreign_key "institutions", "locations"
  add_foreign_key "institutions", "users", column: "director_id"
  add_foreign_key "invites", "institutions"
  add_foreign_key "invites", "users", column: "inviter_id"
  add_foreign_key "medical_center_profiles", "operational_units"
  add_foreign_key "note_editors", "notes"
  add_foreign_key "note_editors", "users"
  add_foreign_key "notes", "users", column: "creator_user_id"
  add_foreign_key "operational_unit_competencies", "competencies"
  add_foreign_key "operational_unit_competencies", "operational_units"
  add_foreign_key "operational_unit_notes", "notes"
  add_foreign_key "operational_unit_notes", "operational_units"
  add_foreign_key "operational_units", "institutions", column: "parent_institution_id"
  add_foreign_key "operational_units", "locations"
  add_foreign_key "operational_units", "users", column: "on_charge_shift_user_id"
  add_foreign_key "operational_units_attachments", "attachments"
  add_foreign_key "operational_units_attachments", "operational_units"
  add_foreign_key "patient_transfers", "events"
  add_foreign_key "patient_transfers", "institutions", column: "destination_institution_id"
  add_foreign_key "patient_transfers", "patients"
  add_foreign_key "patient_transfers", "resources", column: "transport_resource_id"
  add_foreign_key "patient_transfers", "users", column: "accepted_by_user_id"
  add_foreign_key "patient_transfers", "users", column: "requesting_user_id"
  add_foreign_key "patient_vitals", "patients"
  add_foreign_key "patient_vitals", "users", column: "recorded_by_user_id"
  add_foreign_key "patients", "events"
  add_foreign_key "resource_attachments", "attachments"
  add_foreign_key "resource_attachments", "resources"
  add_foreign_key "resource_notes", "notes"
  add_foreign_key "resource_notes", "resources"
  add_foreign_key "resource_types", "resource_categories"
  add_foreign_key "resources", "attachments", column: "icon_id"
  add_foreign_key "resources", "institutions"
  add_foreign_key "resources", "locations"
  add_foreign_key "resources", "resource_types"
  add_foreign_key "schedule_entries", "events"
  add_foreign_key "schedule_entries", "users", column: "creator_user_id"
  add_foreign_key "schedule_entries_institutions", "institutions"
  add_foreign_key "schedule_entries_institutions", "schedule_entries"
  add_foreign_key "user_callsigns", "institutions"
  add_foreign_key "user_callsigns", "users"
  add_foreign_key "user_competencies", "competencies"
  add_foreign_key "user_competencies", "users"
  add_foreign_key "user_contacts", "contacts"
  add_foreign_key "user_contacts", "users"
  add_foreign_key "user_institutions", "institutions"
  add_foreign_key "user_institutions", "users"
  add_foreign_key "user_notes", "notes"
  add_foreign_key "user_notes", "users"
  add_foreign_key "users", "attachments", column: "avatar_id"
end
