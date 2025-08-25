class InstitutionAttachment < ApplicationRecord
  self.primary_key = [ :institution_id, :attachment_id ]

  # Associations
  belongs_to :institution
  belongs_to :attachment

  # Validations
  validates :institution_id, presence: true
  validates :attachment_id, presence: true
end
