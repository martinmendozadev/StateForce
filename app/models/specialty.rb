# frozen_string_literal: true

class Specialty < ApplicationRecord
  # Validations
  validates :description, length: { maximum: 10_000 }, allow_nil: true
  validates :name, presence: true, length: { maximum: 150 }, uniqueness: { case_sensitive: false }
  validates :code, length: { maximum: 50 }, uniqueness: { case_sensitive: false }, allow_nil: true
end
