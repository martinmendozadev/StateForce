# frozen_string_literal: true

class OperationalUnit < ApplicationRecord
  include Enums

  # Associations
  belongs_to :location
  belongs_to :parent_institution, class_name: "Institution"
  belongs_to :on_charge_shift_user, class_name: "User", optional: true

  has_many :operational_unit_notes, dependent: :destroy
  has_many :notes, through: :operational_unit_notes

  has_many :operational_unit_competencies, dependent: :destroy
  has_many :competencies, through: :operational_unit_competencies

  has_many :operational_units_attachments, dependent: :destroy
  has_many :attachments, through: :operational_units_attachments

  # Enums
  enum :triage_status, TRIAGE_STATUSES, prefix: true
  enum :facility_type, FACILITY_TYPES, prefix: true

  # Validations
  validates :location, presence: true
  validates :parent_institution, presence: true
  validates :name, presence: true, length: { maximum: 150 }
  validates :facility_type, presence: true, inclusion: { in: facility_types.keys }
  validates :triage_status, presence: true, inclusion: { in: triage_statuses.keys }
end
