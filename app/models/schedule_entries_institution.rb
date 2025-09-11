# frozen_string_literal: true

class ScheduleEntriesInstitution < ApplicationRecord
  self.primary_key = [ :schedule_entry_id, :institution_id ]

  # Associations
  belongs_to :institution
  belongs_to :schedule_entry

  # Validations
  validates :institution, presence: true
  validates :schedule_entry, presence: true
  validates :schedule_entry_id, uniqueness: { scope: :institution_id }
end
