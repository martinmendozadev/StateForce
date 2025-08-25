class UserInstitution < ApplicationRecord
  self.primary_key = [ :user_id, :institution_id ]

  # Associations
  belongs_to :user
  belongs_to :institution

  # Enums
  enum :role, {
    admin: "admin",
    guest: "guest",
    manager: "manager",
    restricted: "restricted",
    standard: "standard",
    superadmin: "superadmin"
  }, prefix: true

  enum :status, {
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
  }, prefix: true

  # Validations
  validates :position, length: { maximum: 50 }, allow_nil: true
  validates :role, presence: true
  validates :status, presence: true
end
