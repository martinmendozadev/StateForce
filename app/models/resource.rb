# frozen_string_literal: true

class Resource < ApplicationRecord
  # Associations
  belongs_to :institution
  belongs_to :resource_type
  belongs_to :icon, class_name: "Attachment", optional: true
  belongs_to :location

  has_many :notes, as: :noteable, dependent: :destroy
  has_many :event_resources, dependent: :destroy
  has_many :events, through: :event_resources

  # Validations
  validates :name, presence: true, length: { maximum: 150 },
                   uniqueness: { scope: :institution_id, case_sensitive: false }
  validates :institution, presence: true
  validates :resource_type, presence: true
  validates :available_units,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }

  validates :total_units,
            presence: true,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
  validate :available_cannot_exceed_total

  validates :units_identifier, length: { maximum: 50 }, allow_blank: true

  private

  def available_cannot_exceed_total
  return if available_units.nil? || total_units.nil?
  errors.add(:available_units, I18n.t("resource.errors.messages.invalid_total")) if available_units > total_units
  end
end
