class PatientsNote < ApplicationRecord
  self.primary_key = [ :patient_id, :note_id ]

  # Associations
  belongs_to :patient
  belongs_to :note

  # Validations
  validates :patient_id, presence: true
  validates :note_id, presence: true
end
