class UserCallsign < ApplicationRecord
  # Associations
  belongs_to :user
  belongs_to :institution, optional: true

  # Validations
  validates :callsign, presence: true, length: { maximum: 50 }
  validates :callsign, uniqueness: { scope: :institution_id, message: "already assigned in this institution" }
end
