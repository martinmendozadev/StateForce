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
  validates :bed_type, presence: true, inclusion: { in: bed_types.keys }
  validates :available, numericality: { greater_than_or_equal_to: 0 }
  validates :total, numericality: { greater_than_or_equal_to: 0 }
  validate :available_cannot_exceed_total

  private

  def available_cannot_exceed_total
    return if available <= total
    errors.add(:available, "cannot exceed total beds")
  end
end
