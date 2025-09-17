# frozen_string_literal: true

class ScheduleEntry < ApplicationRecord
  include Enums

  # Associations
  belongs_to :event
  belongs_to :creator_user, class_name: "User"

  has_many :schedule_entries_institutions, dependent: :destroy
  has_many :institutions, through: :schedule_entries_institutions

  # Enums
  enum :status, STATUS, prefix: true
  enum :visibility, VISIBILITIES, prefix: true
  enum :priority_level, PRIORITY_LEVELS, prefix: true
  enum :recurrence_rule, RECURRENCE_RULES, prefix: true

  # Validations
  validates :event, presence: true
  validates :status, presence: true
  validates :visibility, presence: true
  validates :creator_user, presence: true
  validates :priority_level, presence: true
  validates :recurrence_rule, presence: true
  validates :title, presence: true, length: { maximum: 100 }
end
