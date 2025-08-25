class Invite < ApplicationRecord
  # Associations
  belongs_to :institution
  belongs_to :inviter, class_name: "User"

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
  validates :email, presence: true, length: { maximum: 150 }, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates :expires_at, presence: true
  validates :token, presence: true, uniqueness: true
  validates :role, presence: true
  validates :status, presence: true

  # Scopes
  scope :active, -> { where(status: :pending).where("expires_at > ?", Time.current) }
end
