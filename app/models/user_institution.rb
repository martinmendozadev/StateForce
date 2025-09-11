# frozen_string_literal: true

class UserInstitution < ApplicationRecord
  include Enums

  self.primary_key = [ :user_id, :institution_id ]

  # Associations
  belongs_to :user
  belongs_to :institution

  # Enums
  enum :role, ROLES, prefix: true
  enum :status, INVITE_STATUSES, prefix: true

  # Validations
  validates :role, presence: true
  validates :user, presence: true
  validates :status, presence: true
  validates :institution, presence: true
  validates :position, length: { maximum: 50 }, allow_nil: true
end
