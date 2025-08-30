# frozen_string_literal: true

class ContactPhoneNumber < ApplicationRecord
  self.primary_key = [ :contact_id, :phone_number_id ]

  # Associations
  belongs_to :contact
  belongs_to :phone_number

  # Validations
  validates :is_primary, inclusion: { in: [ true, false ] }

  # Scopes
  scope :primary, -> { where(is_primary: true) }
end
