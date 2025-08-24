class Competency < ApplicationRecord
  # Associations
  belongs_to :specialty

  # Enums
  enum :level, {
    advanced: "advanced",
    basic: "basic",
    medium: "medium",
    unknown: "unknown"
  }, prefix: true

  # Validations
  validates :specialty_id, presence: true
  validates :level, uniqueness: { scope: :specialty_id }
  validates :level, presence: true, inclusion: { in: levels.keys }
end
