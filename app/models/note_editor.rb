class NoteEditor < ApplicationRecord
  self.primary_key = [ :note_id, :user_id ]

  # Associations
  belongs_to :note
  belongs_to :user

  # Validations
  validates :note_id, presence: true
  validates :user_id, presence: true
  validates :last_edited_at, presence: true
end
