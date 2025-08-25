class ContactPhoneNumber < ApplicationRecord
  self.primary_key = [ :contact_id, :phone_number_id ]

  # Associations
  belongs_to :contact
  belongs_to :phone_number

  # Validations
  validates :contact_id, presence: true
  validates :phone_number_id, presence: true
  validates :is_primary, inclusion: { in: [ true, false ] }

  # Scope para obtener números primarios
  scope :primary, -> { where(is_primary: true) }
end
