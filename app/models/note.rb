# frozen_string_literal: true

class Note < ApplicationRecord
  include Enums

  # Relationships
  belongs_to :creator_user, class_name: "User"
  belongs_to :noteable, polymorphic: true
  has_many :note_editors, dependent: :destroy
  has_many :editors, through: :note_editors, source: :user

  # Enums
  enum :visibility, VISIBILITIES, prefix: true

  # Validations
  validates :creator_user, presence: true
  validates :noteable, presence: true
  validates :title, presence: true, length: { maximum: 150 }
  validates :body, presence: true, length: { minimum: 1 }
  validates :visibility, presence: true, inclusion: { in: visibilities.keys }

  # Scopes
  scope :active, -> { where(deleted_at: nil) }
end
