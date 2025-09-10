# frozen_string_literal: true

class PhoneNumber < ApplicationRecord
  include Enums

  # Associations
  has_many :contact_phone_numbers, dependent: :destroy
  has_many :contacts, through: :contact_phone_numbers

  # Enums
  enum :phone_type, PHONE_TYPES, prefix: true

  # Validations
  validates :number, length: { maximum: 25 }, presence: true
  validates :extension, length: { maximum: 3 }, allow_blank: true
  validates :phone_type, presence: true, inclusion: { in: phone_types.keys }
end
