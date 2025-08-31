# frozen_string_literal: true

class NoteEditor < ApplicationRecord
  self.primary_key = [ :note_id, :user_id ]

  # Associations
  belongs_to :note
  belongs_to :user

  # Validations
  validates :note, presence: true
  validates :user, presence: true
  validates :last_edited_at, timeliness: { type: :datetime }, allow_nil: true, if: -> { respond_to?(:last_edited_at) }
end
