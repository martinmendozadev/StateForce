class Competency < ApplicationRecord
  # Associations
  belongs_to :specialty

  has_many :operational_unit_competencies, dependent: :destroy
  has_many :operational_units, through: :operational_unit_competencies

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
