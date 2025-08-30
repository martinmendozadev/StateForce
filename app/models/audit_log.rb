# frozen_string_literal: true

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
  validates :action, presence: true
  validates :entity_id,
            presence: true,
            numericality: { only_integer: true, greater_than: 0 }

  validates :entity_name, presence: true

  validates :new_value,
            presence: true
  validate :validate_json_fields

  private

  def validate_json_fields
    errors.add(:new_value, "must be a JSON object") unless new_value.is_a?(Hash)
    errors.add(:old_value, "must be a JSON object") if old_value.present? && !old_value.is_a?(Hash)
  end
end
