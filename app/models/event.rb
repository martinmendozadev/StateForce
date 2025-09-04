# frozen_string_literal: true

class Event < ApplicationRecord
  ## Relationships
  belongs_to :location, optional: true

  has_many :notes, as: :noteable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy

  has_many :event_institutions, dependent: :destroy
  has_many :institutions, through: :event_institutions

  has_many :event_resources, dependent: :destroy
  has_many :resources, through: :event_resources

  ## Enums
  enum :event_type, {
    animal_rescue: "animal_rescue",
    bomb_threat: "bomb_threat",
    emergency: "emergency",
    epidemic_response: "epidemic_response",
    evacuation: "evacuation",
    fire_incident: "fire_incident",
    flood_response: "flood_response",
    hazardous_material: "hazardous_material",
    infrastructure_collapse: "infrastructure_collapse",
    medical_emergency: "medical_emergency",
    missing_person: "missing_person",
    natural_disaster: "natural_disaster",
    operative: "operative",
    other: "other",
    power_outage: "power_outage",
    public_disturbance: "public_disturbance",
    rescue_operation: "rescue_operation",
    simulacrum: "simulacrum",
    support_request: "support_request",
    traffic_accident: "traffic_accident",
    training: "training",
    unknown: "unknown"
  }, prefix: true

  enum :priority_level, {
    critical: "critical",
    high: "high",
    low: "low",
    medium: "medium",
    unknown: "unknown"
  }, prefix: true

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
  validates :reported_time, presence: true
  validates :status, presence: true
  validates :event_type, presence: true
  validates :priority_level, presence: true

  validates :event_code,
            uniqueness: true,
            length: { maximum: 50 },
            allow_nil: true

  validates :reported_by_text,
            length: { maximum: 150 },
            allow_nil: true

  validates :people_affected,
            numericality: { only_integer: true, greater_than_or_equal_to: 0 }
end
