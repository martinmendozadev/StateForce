# frozen_string_literal: true

class InstitutionContact < ApplicationRecord
  include Enums

  self.primary_key = [ :institution_id, :contact_id, :contact_type ]

  # Associations
  belongs_to :institution
  belongs_to :contact

  # Enum
  enum :contact_type, CONTACT_TYPES, prefix: true

  # Validations
  validates :contact_id, presence: true
  validates :contact_type, presence: true, inclusion: { in: contact_types.keys }
  validates :institution_id, presence: true, uniqueness: { scope: [ :contact_id, :contact_type ], message: "association already exists for this contact and type" }
end
