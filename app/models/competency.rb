# frozen_string_literal: true

class Competency < ApplicationRecord
  include Enums
  # Associations
  belongs_to :specialty

  has_many :operational_unit_competencies, dependent: :destroy
  has_many :operational_units, through: :operational_unit_competencies

  # Enums
  enum :level, LEVELS, prefix: true

  # Validations
  validates :level, presence: true, inclusion: { in: levels.keys }, uniqueness: { scope: :specialty_id }
  validates :specialty, presence: true
end
