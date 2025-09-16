# frozen_string_literal: true

class ResourceType < ApplicationRecord
  # Associations
  belongs_to :resource_category

  has_many :resources, dependent: :nullify

  # Validations
  validates :resource_category, presence: true
  validates :name,
            presence: true,
            length: { maximum: 150 },
            uniqueness: { scope: :resource_category_id, case_sensitive: false }
  validates :description, length: { maximum: 5000 }, allow_nil: true
end
