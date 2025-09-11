# frozen_string_literal: true

class Patient < ApplicationRecord
  include Enums

  # Relationships
  belongs_to :event

  has_many :notes, as: :noteable, dependent: :destroy

  # Enums
  enum :gender, GENDERS, prefix: true
  enum :triage_status, TRIAGE_STATUSES, prefix: true

  # Validations
  validates :event, presence: true
  validates :name, presence: true, length: { maximum: 100 }
  validates :gender, presence: true, inclusion: { in: genders.keys }
  validates :triage_status, presence: true, inclusion: { in: triage_statuses.keys }
  validates :age, presence: true, numericality: { only_integer: true, greater_than_or_equal_to: 0, less_than_or_equal_to: 125 }
end
