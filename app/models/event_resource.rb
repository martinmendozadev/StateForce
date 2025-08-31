# frozen_string_literal: true

class EventResource < ApplicationRecord
  # Associations
  belongs_to :event
  belongs_to :resource
  belongs_to :assigned_by_user, class_name: "User"

  # Validations
  validates :assigned_at, presence: true
  validates :event, presence: true
  validates :resource, presence: true
  validates :assigned_by_user, presence: true
  validates :event_id, uniqueness: { scope: :resource_id }
  validates :quantity_assigned, presence: true, numericality: { only_integer: true, greater_than: 0 }
end
