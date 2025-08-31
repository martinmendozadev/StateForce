# frozen_string_literal: true

class UserCompetency < ApplicationRecord
  self.primary_key = [ :user_id, :competency_id ]

  # Associations
  belongs_to :user
  belongs_to :competency

  # Validations
  validates :user, presence: true
  validates :competency, presence: true
  validates :user_id, uniqueness: { scope: :competency_id }
  validates :expiry_date, comparison: { greater_than_or_equal_to: Date.today }, allow_nil: true
end
