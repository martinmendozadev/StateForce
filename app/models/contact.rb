class Contact < ApplicationRecord
  # Associations
  # has_many :institution_contacts, dependent: :destroy
  # has_many :user_contacts, dependent: :destroy
  # has_many :contact_phone_numbers, dependent: :destroy

  # Validations
  validates :email,
            presence: true,
            uniqueness: true,
            length: { maximum: 150 },
            format: { with: URI::MailTo::EMAIL_REGEXP }

  validates :name,
            length: { maximum: 50 },
            allow_nil: true

  validates :radio_frequency,
            length: { maximum: 75 },
            allow_nil: true
end
