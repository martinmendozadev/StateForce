# frozen_string_literal: true

class OperationalUnitCompetency < ApplicationRecord
  self.primary_key = %i[operational_unit_id competency_id]

  # Associations
  belongs_to :competency
  belongs_to :operational_unit

  # Validations
  validates :competency, presence: true
  validates :operational_unit, presence: true
  validates :operational_unit_id, uniqueness: {
    scope: :competency_id,
    message: I18n.t("operational_unit_competency.errors.messages.association_exists")
  }

  # Scopes
  scope :active, -> { where(deleted_at: nil) }
end
