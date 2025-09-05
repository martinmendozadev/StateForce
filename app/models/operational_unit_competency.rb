# frozen_string_literal: true

class OperationalUnitCompetency < ApplicationRecord
  self.primary_keys = %i[operational_unit_id competency_id]

  ## Associations
  belongs_to :operational_unit
  belongs_to :competency

  ## Validations
  validates :operational_unit, presence: true
  validates :competency, presence: true
  validates :operational_unit_id, uniqueness: {
    scope: :competency_id,
    message: "association with this competency already exists"
  }

  ## Scopes
  scope :active, -> { where(deleted_at: nil) }
end
