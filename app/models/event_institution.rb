# frozen_string_literal: true

class EventInstitution < ApplicationRecord
  self.primary_key = [ :event_id, :institution_id ]

  # Associations
  belongs_to :event
  belongs_to :institution

  # Validations
  validates :event, presence: true
  validates :institution, presence: true
  validates :event_id, uniqueness: { scope: :institution_id }
  validates :assigned_at, presence: true
end
