class EventInstitution < ApplicationRecord
  self.primary_key = [ :event_id, :institution_id ]

  belongs_to :event
  belongs_to :institution

  validates :event_id, uniqueness: { scope: :institution_id }
  validates :assigned_at, presence: true
end
