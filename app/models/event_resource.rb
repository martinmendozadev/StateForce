class EventResource < ApplicationRecord
  belongs_to :event
  belongs_to :resource
  belongs_to :assigned_by_user, class_name: "User"

  validates :quantity_assigned, presence: true, numericality: { greater_than: 0 }
  validates :assigned_at, presence: true
  validates :event_id, uniqueness: { scope: :resource_id }
end
