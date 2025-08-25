class ResourceNote < ApplicationRecord
  self.primary_key = [ :resource_id, :note_id ]

  # Associations
  belongs_to :resource
  belongs_to :note

  # Validations
  validates :resource_id, presence: true
  validates :note_id, presence: true
end
