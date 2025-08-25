class Specialty < ApplicationRecord
  # Validations
  validates :name, presence: true, length: { maximum: 150 }, uniqueness: true
  validates :code, length: { maximum: 50 }, uniqueness: true, allow_nil: true
  validates :description, length: { maximum: 10_000 }, allow_nil: true
end
