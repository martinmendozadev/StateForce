class EventNote < ApplicationRecord
  self.primary_key = [ :event_id, :note_id ]

  # Associations
  belongs_to :event
  belongs_to :note

  # Validations
  validates :event_id, presence: true
  validates :note_id, presence: true
end
