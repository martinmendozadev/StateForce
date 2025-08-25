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
  validates :level, presence: true, inclusion: { in: levels.keys }
  validates :operating_rooms_total, numericality: { greater_than_or_equal_to: 0 }
  validates :operating_rooms_available, numericality: { greater_than_or_equal_to: 0 }
  validate :available_rooms_cannot_exceed_total

  private

  def available_rooms_cannot_exceed_total
    return if operating_rooms_available <= operating_rooms_total
    errors.add(:operating_rooms_available, "cannot exceed total operating rooms")
  end
end
