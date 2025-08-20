class ScheduleEntry < ApplicationRecord
  belongs_to :creator_user, class_name: "User"
  belongs_to :event, optional: true

  # Enums
  enum :priority_level, {
    critical: "critical",
    high: "high",
    low: "low",
    medium: "medium",
    unknown: "unknown"
  }, prefix: true

  enum :recurrence_rule, {
    once: "once",
    daily: "daily",
    weekly: "weekly",
    monthly: "monthly",
    yearly: "yearly"
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

  enum :visibility, {
    public: "public",
    private: "private",
    restricted: "restricted"
  }, prefix: true

  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :priority_level, presence: true
  validates :recurrence_rule, presence: true
  validates :status, presence: true
  validates :visibility, presence: true
end
