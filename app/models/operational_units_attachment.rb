class OperationalUnitsAttachment < ApplicationRecord
  self.primary_key = [ :operational_unit_id, :attachment_id ]

  # Associations
  belongs_to :operational_unit
  belongs_to :attachment

  # Validations
  validates :operational_unit_id, presence: true
  validates :attachment_id, presence: true
end
