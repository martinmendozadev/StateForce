class OperationalUnitCompetency < ApplicationRecord
  self.primary_key = [ :operational_unit_id, :competency_id ]

  # Associations
  belongs_to :operational_unit
  belongs_to :competency

  # Validations
  validates :operational_unit_id, presence: true
  validates :competency_id, presence: true
end
