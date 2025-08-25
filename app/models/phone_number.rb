class PhoneNumber < ApplicationRecord
  # Associations
  has_many :contact_phone_numbers, dependent: :destroy
  has_many :contacts, through: :contact_phone_numbers

  # Enums
  enum :phone_type, {
    home: "home",
    landline: "landline",
    mobile: "mobile",
    office: "office",
    other: "other",
    personal: "personal",
    unknown: "unknown"
  }, prefix: true

  # Validations
  validates :number, presence: true, length: { maximum: 25 }
  validates :extension, length: { maximum: 3 }, allow_blank: true
  validates :phone_type, presence: true, inclusion: { in: phone_types.keys }
end
