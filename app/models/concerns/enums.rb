# frozen_string_literal: true

module Enums
  ACTIONS = {
    created: "created",
    deleted: "deleted",
    read: "read",
    restored: "restored",
    updated: "updated"
  }.freeze

  BED_TYPES = {
    emergency: "emergency",
    gynecology: "gynecology",
    icu: "icu",
    internal_medicine: "internal_medicine",
    isolated: "isolated",
    neonatal_icu: "neonatal_icu",
    pediatric: "pediatric",
    trauma: "trauma",
    general: "general",
    maternity: "maternity"
  }.freeze

  CONTACT_TYPES = {
    emergency: "emergency",
    primary: "primary",
    technical_support: "technical_support"
  }.freeze

  ENTITY_NAMES = {
    contacts: "contacts",
    events: "events",
    resources: "resources",
    user: "user",
    patients: "patients",
    institutions: "institutions",
    attachments: "attachments",
    schedule_entries: "schedule_entries",
    phone_numbers: "phone_numbers",
    invites: "invites",
    resource_categories: "resource_categories",
    resource_types: "resource_types",
    patient_transfers: "patient_transfers",
    audit_logs: "audit_logs",
    unknown: "unknown"
  }.freeze

  EVENT_TYPES = {
    animal_rescue: "animal_rescue",
    bomb_threat: "bomb_threat",
    emergency: "emergency",
    epidemic_response: "epidemic_response",
    evacuation: "evacuation",
    fire_incident: "fire_incident",
    flood_response: "flood_response",
    hazardous_material: "hazardous_material",
    infrastructure_collapse: "infrastructure_collapse",
    medical_emergency: "medical_emergency",
    missing_person: "missing_person",
    natural_disaster: "natural_disaster",
    operative: "operative",
    other: "other",
    power_outage: "power_outage",
    public_disturbance: "public_disturbance",
    rescue_operation: "rescue_operation",
    simulacrum: "simulacrum",
    support_request: "support_request",
    traffic_accident: "traffic_accident",
    training: "training",
    unknown: "unknown"
  }.freeze

  FACILITY_TYPES = {
    hospital: "hospital",
    clinic: "clinic",
    rescue_base: "rescue_base",
    command_center: "command_center",
    other: "other"
}.freeze

  FILE_TYPES = {
    certification: "certification",
    document:      "document",
    image:         "image",
    other:         "other",
    video:         "video"
  }.freeze

  GENDERS = {
    female: "female",
    intersex: "intersex",
    male: "male",
    other: "other"
  }.freeze

  INSTITUTION_STATUSES = {
    available: "available",
    maintenance: "maintenance",
    out_of_service: "out_of_service",
    unknown: "unknown"
  }.freeze

  LEVELS = {
    advanced: "advanced",
    basic: "basic",
    medium: "medium",
    unknown: "unknown"
  }.freeze

  PHONE_TYPES = {
    home: "home",
    landline: "landline",
    mobile: "mobile",
    office: "office",
    other: "other",
    personal: "personal",
    unknown: "unknown"
  }.freeze

  PRIORITY_LEVELS = {
    critical: "critical",
    high: "high",
    low: "low",
    medium: "medium",
    unknown: "unknown"
  }.freeze

  RECURRENCE_RULES = {
    once: "once",
    daily: "daily",
    weekly: "weekly",
    monthly: "monthly",
    yearly: "yearly"
  }.freeze

  ROLES = {
    admin: "admin",
    guest: "guest",
    manager: "manager",
    restricted: "restricted",
    standard: "standard",
    superadmin: "superadmin"
  }.freeze

  INVITE_STATUSES = {
    active: "active",
    accepted: "accepted",
    cancelled: "cancelled",
    done: "done",
    draft: "draft",
    expired: "expired",
    paused: "paused",
    pending: "pending",
    retired: "retired",
    revoked: "revoked",
    sent: "sent",
    unknown: "unknown"
  }.freeze

  STATUS = {
    assigned: "assigned",
    arrived: "arrived",
    cancelled: "cancelled",
    closed: "closed",
    en_route: "en_route",
    on_scene: "on_scene",
    pending: "pending",
    resolved: "resolved"
  }.freeze

  SECTOR_TYPES = {
    public: "public",
    private: "private",
    social: "social",
    unknown: "unknown"
  }.freeze

  TRIAGE_STATUSES = {
    black: "black",
    green: "green",
    red: "red",
    unknown: "unknown",
    yellow: "yellow"
  }.freeze

  VISIBILITIES = {
    public:     "public",
    private:    "private",
    restricted: "restricted"
  }.freeze
end
