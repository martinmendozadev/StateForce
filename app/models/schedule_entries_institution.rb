class ScheduleEntriesInstitution < ApplicationRecord
  self.primary_key = [ :schedule_entry_id, :institution_id ]

  # Associations
  belongs_to :schedule_entry
  belongs_to :institution

  # Validations
  validates :schedule_entry_id, presence: true
  validates :institution_id, presence: true
end
