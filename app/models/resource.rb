class Resource < ApplicationRecord
  # Associations
  belongs_to :institution
  belongs_to :resource_type
  belongs_to :icon, class_name: "Attachment", optional: true
  belongs_to :location, optional: true

  has_many :event_resources, dependent: :destroy
  has_many :events, through: :event_resources

  # Validations
  validates :name, presence: true, length: { maximum: 150 },
                   uniqueness: { scope: :institution_id, case_sensitive: false }

  validates :available_units, numericality: { greater_than_or_equal_to: 0 }
  validates :total_units, numericality: { greater_than_or_equal_to: 0 }
  validate :available_cannot_exceed_total

  validates :units_identifier, length: { maximum: 50 }, allow_blank: true

  private

  def available_cannot_exceed_total
    return if available_units.blank? || total_units.blank?
    errors.add(:available_units, "cannot exceed total units") if available_units > total_units
  end
end
