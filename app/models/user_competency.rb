class UserCompetency < ApplicationRecord
  self.primary_key = [ :user_id, :competency_id ]

  # Associations
  belongs_to :user
  belongs_to :competency

  # Validations
  validates :user_id, presence: true
  validates :competency_id, presence: true
  validates :expiry_date, comparison: { greater_than_or_equal_to: Date.today }, allow_nil: true
end
