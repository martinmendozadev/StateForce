# frozen_string_literal: true

class NoteEditor < ApplicationRecord
  ## Composite primary key
  self.primary_key = %i[note_id user_id]

  # Associations
  belongs_to :note
  belongs_to :user

  # Validations
  validates :note, presence: true
  validates :user, presence: true

  # Validación de unicidad por clave compuesta
  validates :user_id, uniqueness: { scope: :note_id, message: "already assigned as editor for this note" }

  # Validación de fecha
  validates :last_edited_at, timeliness: { type: :datetime }, allow_nil: true

  # Opcional: asegurar que no haya fechas futuras incoherentes
  validate :last_edited_at_cannot_be_in_future, if: -> { last_edited_at.present? }

  private

  def last_edited_at_cannot_be_in_future
    return unless last_edited_at > Time.current
    errors.add(:last_edited_at, "cannot be in the future")
  end
end
