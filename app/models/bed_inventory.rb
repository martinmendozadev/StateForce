# frozen_string_literal: true

class BedInventory < ApplicationRecord
  # Associations
  belongs_to :operational_unit

  # Enums
  enum :bed_type, {
    emergency: "emergency",
    gynecology: "gynecology",
    icu: "icu",
    internal_medicine: "internal_medicine",
    isolated: "isolated",
    neonatal_icu: "neonatal_icu",
    pediatric: "pediatric",
    trauma: "trauma",
    general: "general",
    maternity: "maternity"
  }, prefix: true

  # Validations
  validates :bed_type, presence: true

  validates :operational_unit, presence: true

  validates :available,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :total,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validate :available_cannot_exceed_total

  private

  def available_cannot_exceed_total
    return if available.nil? || total.nil?
    errors.add(:available, "cannot exceed total beds") if available > total
  end
end
