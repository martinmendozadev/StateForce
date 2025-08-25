class UserContact < ApplicationRecord
  self.primary_key = [ :user_id, :contact_id, :contact_type ]

  # Associations
  belongs_to :user
  belongs_to :contact

  # Enums
  enum :contact_type, {
    emergency: "emergency",
    primary: "primary",
    technical_support: "technical_support"
  }, prefix: true

  # Validations
  validates :user_id, presence: true
  validates :contact_id, presence: true
  validates :contact_type, presence: true, inclusion: { in: contact_types.keys }
end
