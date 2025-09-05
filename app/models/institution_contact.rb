# frozen_string_literal: true

class InstitutionContact < ApplicationRecord
  self.primary_key = [ :institution_id, :contact_id, :contact_type ]

  ## Associations
  belongs_to :institution
  belongs_to :contact

  ## Enum
  enum :contact_type, {
    emergency: "emergency",
    primary: "primary",
    technical_support: "technical_support"
  }, prefix: true

  ## Validations
  validates :institution_id, presence: true, uniqueness: { scope: [ :contact_id, :contact_type ], message: "association already exists for this contact and type" }
  validates :contact_id, presence: true
  validates :contact_type, presence: true, inclusion: { in: contact_types.keys }
end
