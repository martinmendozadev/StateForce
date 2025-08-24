class AuditLog < ApplicationRecord
  # Associations
  belongs_to :user, optional: true

  # Enums
  enum :action, {
    created: "created",
    deleted: "deleted",
    read: "read",
    restored: "restored",
    updated: "updated"
  }, prefix: true

  enum :entity_name, {
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
  }, prefix: true

  # Validations
  validates :action, presence: true, inclusion: { in: actions.keys }
  validates :entity_id, presence: true
  validates :entity_name, presence: true, inclusion: { in: entity_names.keys }
end
