# frozen_string_literal: true

module Enums
  ACTIONS = {
    created: "created",
    deleted: "deleted",
    read: "read",
    restored: "restored",
    updated: "updated"
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

  FILE_TYPES = {
    certification: "certification",
    document:      "document",
    image:         "image",
    other:         "other",
    video:         "video"
  }.freeze

  VISIBILITIES = {
    public:     "public",
    private:    "private",
    restricted: "restricted"
  }.freeze
end
