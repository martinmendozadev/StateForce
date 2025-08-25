class UserNote < ApplicationRecord
  self.primary_key = [ :user_id, :note_id ]

  # Associations
  belongs_to :user
  belongs_to :note

  # Validations
  validates :user_id, presence: true
  validates :note_id, presence: true
  validates :starred, inclusion: { in: [ true, false ] }

  # Scopes
  scope :starred, -> { where(starred: true) }
end
