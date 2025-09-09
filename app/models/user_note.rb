# frozen_string_literal: true

class UserNote < ApplicationRecord
  self.primary_key = [ :user_id, :note_id ]

  # Associations
  belongs_to :user
  belongs_to :note

  # Validations
  validates :user, presence: true
  validates :note, presence: true
  validates :starred, inclusion: { in: [ true, false ] }

  # Scopes
  scope :starred, -> { where(starred: true) }
end
