class OperationalUnitNote < ApplicationRecord
  self.primary_key = [ :operational_unit_id, :note_id ]

  ## Relationships
  belongs_to :operational_unit
  belongs_to :note

  ## Validations
  validates :note_id, uniqueness: { scope: :operational_unit_id }
end
