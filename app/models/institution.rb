# frozen_string_literal: true

class Institution < ApplicationRecord
  include Enums

  # Associations
  belongs_to :location
  belongs_to :director, class_name: "User", optional: true
  belongs_to :parent_institution, class_name: "Institution", optional: true

  has_many :notes, as: :noteable, dependent: :destroy
  has_many :attachments, as: :attachable, dependent: :destroy

  has_many :event_institutions, dependent: :destroy
  has_many :events, through: :event_institutions

  has_many :institution_contacts, dependent: :destroy
  has_many :contacts, through: :institution_contacts

  has_many :schedule_entries_institutions, dependent: :destroy
  has_many :schedule_entries, through: :schedule_entries_institutions

  # Enums
  enum :sector_type, SECTOR_TYPES, prefix: true
  enum :status, INSTITUTION_STATUSES, prefix: true

  # Validations
  validates :location, presence: true
  validates :name, presence: true, length: { maximum: 150 }
  validates :callsign, length: { maximum: 100 }, allow_nil: true
  validates :sector_type, presence: true, inclusion: { in: sector_types.keys }
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :callsign, uniqueness: { scope: :name, message: I18n.t("enums.errors.messages.invalid_combination") }

  # Scopes
  scope :active_institutions, -> { where(status: statuses[:available]) }
end
