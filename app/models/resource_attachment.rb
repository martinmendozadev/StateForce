class ResourceAttachment < ApplicationRecord
  self.primary_key = [ :resource_id, :attachment_id ]

  # Associations
  belongs_to :resource
  belongs_to :attachment

  # Validations
  validates :resource_id, presence: true
  validates :attachment_id, presence: true
end
