class EventAttachment < ApplicationRecord
  self.primary_key = [ :event_id, :attachment_id ]

  # Associations
  belongs_to :event
  belongs_to :attachment

  # Validations
  validates :event_id, presence: true
  validates :attachment_id, presence: true
end
