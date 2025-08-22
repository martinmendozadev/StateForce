class ResourceCategory < ApplicationRecord
  # Associations
  has_many :resources, dependent: :nullify

  # Validations
  validates :name,
            presence: true,
            length: { maximum: 150 },
            uniqueness: { case_sensitive: false }
  validates :description, length: { maximum: 5000 }, allow_nil: true
end
