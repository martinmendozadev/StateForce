class PatientTransfer < ApplicationRecord
  # Associations
  belongs_to :accepted_by_user, class_name: "User"
  belongs_to :destination_institution, class_name: "Institution"
  belongs_to :event
  belongs_to :patient
  belongs_to :requesting_user, class_name: "User"
  belongs_to :transport_resource, class_name: "Resource"

  # Enums
  enum :status, {
    assigned: "assigned",
    arrived: "arrived",
    cancelled: "cancelled",
    closed: "closed",
    en_route: "en_route",
    on_scene: "on_scene",
    pending: "pending",
    resolved: "resolved"
  }, prefix: true

  # Validations
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :departure_time, presence: true
  validates :arrival_time, comparison: { greater_than: :departure_time }, allow_nil: true
end
