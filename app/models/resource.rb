# frozen_string_literal: true

class Resource < ApplicationRecord
  # Associations
  belongs_to :location
  belongs_to :institution
  belongs_to :resource_type
  belongs_to :icon, class_name: "Attachment", optional: true

  has_many :events, through: :event_resources
  has_many :event_resources, dependent: :destroy
  has_many :notes, as: :noteable, dependent: :destroy

  # Validations
  validates :institution, presence: true
  validate :available_cannot_exceed_total
  validates :resource_type, presence: true
  validates :units_identifier, length: { maximum: 50 }, allow_blank: true

  validates :name, presence: true, length: { maximum: 150 },
                   uniqueness: { scope: :institution_id, case_sensitive: false }
  validates :available_units,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :total_units,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  # Scopes
  scope :vehicles_resource_available, ->(type_name) {
    joins(:resource_type)
      .where(resource_types: { name: type_name })
      .where("available_units > 0").sum(:available_units)
  }

  # Returns percentage of availability for resources with type name "Bed"
  def self.percentage_hospitals_beds_available
    relation = joins(:resource_type).where(resource_types: { name: "Bed" })
    total_available = relation.sum(:available_units)
    total_units = relation.sum(:total_units)

    return 100.0 if total_units.to_i <= 0

    ((total_available.to_f / total_units.to_f) * 100).round(2)
  end

  private

  def available_cannot_exceed_total
  return if available_units.nil? || total_units.nil?
  errors.add(:available_units, I18n.t("resource.errors.messages.invalid_total")) if available_units > total_units
  end
end
