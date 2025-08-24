class OperationalUnit < ApplicationRecord
  # Associations
  belongs_to :location
  belongs_to :parent_institution, class_name: "Institution"
  belongs_to :on_charge_shift_user, class_name: "User", optional: true

  # Enums
  enum :triage_status, {
    black: "black",
    green: "green",
    red: "red",
    unknown: "unknown",
    yellow: "yellow"
  }, prefix: true

  enum :facility_type, {
    hospital: "hospital",
    clinic: "clinic",
    rescue_base: "rescue_base",
    command_center: "command_center",
    other: "other"
  }, prefix: true

  # Validations
  validates :name, presence: true, length: { maximum: 150 }
  validates :triage_status, presence: true, inclusion: { in: triage_statuses.keys }
  validates :facility_type, presence: true, inclusion: { in: facility_types.keys }
end
