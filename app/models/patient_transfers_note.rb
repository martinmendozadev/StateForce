class PatientTransfersNote < ApplicationRecord
  self.primary_key = [ :patient_transfer_id, :note_id ]

  # Associations
  belongs_to :patient_transfer
  belongs_to :note

  # Validations
  validates :patient_transfer_id, presence: true
  validates :note_id, presence: true
end
