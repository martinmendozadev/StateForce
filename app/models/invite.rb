# frozen_string_literal: true

class Invite < ApplicationRecord
  include Enums

  # Associations
  belongs_to :institution
  belongs_to :inviter, class_name: "User", optional: true

  # Enums
  enum :role, ROLES, prefix: true
  enum :status, INVITE_STATUSES, prefix: true

  # Validations
  validates :institution, presence: true
  validates :role, presence: true, inclusion: { in: roles.keys }
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :expires_at, presence: true
  validates :token, presence: true, uniqueness: true
  validates :email,
            presence: true,
            length: { maximum: 150 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  # Scopes
  scope :pending_and_valid, -> { where(status: :pending).where("expires_at > ?", Time.current) }
end
