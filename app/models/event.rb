# frozen_string_literal: true

class Event < ApplicationRecord
  include Enums

  # Associations
  belongs_to :location, optional: true

  has_many :notes, as: :noteable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy

  has_many :event_institutions, dependent: :destroy
  has_many :institutions, through: :event_institutions

  has_many :event_resources, dependent: :destroy
  has_many :resources, through: :event_resources

  # Enums
  enum :status, STATUS, prefix: true
  enum :event_type, EVENT_TYPES, prefix: true
  enum :priority_level, PRIORITY_LEVELS, prefix: true

  # Validations
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

  # Scopes
  scope :active_events, -> { statuses.excluding(:resolved) }
  scope :last_events, ->(limit = 5) { order(updated_at: :desc).limit(limit) }
  scope :group_by_attribute, ->(attribute) { group(attribute).order(attribute => :asc) }
end
