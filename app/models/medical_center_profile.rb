# frozen_string_literal: true

class MedicalCenterProfile < ApplicationRecord
  # Associations
  belongs_to :operational_unit

  # Enums
  enum :level, {
    advanced: "advanced",
    basic: "basic",
    medium: "medium",
    unknown: "unknown"
  }, prefix: true

  # Validations
  validates :operational_unit, presence: true
  validate :available_rooms_cannot_exceed_total
  validates :level, presence: true, inclusion: { in: levels.keys }
  validates :operating_rooms_total, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validates :operating_rooms_available, numericality: {
    less_than_or_equal_to: :operating_rooms_total,
    message: "cannot exceed total operating rooms"
  }

  private

  def available_rooms_cannot_exceed_total
    return if operating_rooms_available <= operating_rooms_total
    errors.add(:operating_rooms_available, "cannot exceed total operating rooms")
  end
end
