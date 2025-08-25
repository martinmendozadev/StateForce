class InstitutionNote < ApplicationRecord
  self.primary_key = [ :institution_id, :note_id ]

  # Associations
  belongs_to :institution
  belongs_to :note

  # Validations
  validates :institution_id, presence: true
  validates :note_id, presence: true
end
