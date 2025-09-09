# frozen_string_literal: true

class PatientTransfer < ApplicationRecord
  ## Associations
  belongs_to :accepted_by_user, class_name: "User"
  belongs_to :destination_institution, class_name: "Institution"
  belongs_to :event
  belongs_to :patient
  belongs_to :requesting_user, class_name: "User"
  belongs_to :transport_resource, class_name: "Resource"

  has_many :notes, as: :noteable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy

  ## Enums
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

  ## Validations
  validates :event, presence: true
  validates :patient, presence: true
  validates :departure_time, presence: true
  validates :requesting_user, presence: true
  validates :accepted_by_user, presence: true
  validates :transport_resource, presence: true
  validates :destination_institution, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :arrival_time, comparison: { greater_than: :departure_time }, allow_nil: true
end
