# frozen_string_literal: true

class Institution < ApplicationRecord
  include Enums

  # Associations
  belongs_to :location
  belongs_to :director, class_name: "User", optional: true
  belongs_to :parent_institution, class_name: "Institution", optional: true

  has_many :resources, dependent: :destroy

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
  scope :last_institutions, ->(limit = 5) { order(updated_at: :desc).limit(limit).includes(:resources) }

  # Calculations
  def resources_totals
    res = resources
    if !res.loaded?
      # Load only required columns if association not preloaded
      res = res.select(:available_units, :total_units)
    end

    total_units = 0
    available_units = 0

    res.each do |r|
      total_units += r.total_units.to_i
      available_units += r.available_units.to_i
    end

    { total_units: total_units, available_units: available_units }
  end

  def availability_percentage
    totals = resources_totals
    return 0 if totals[:total_units].to_i <= 0
    ((totals[:available_units].to_f / totals[:total_units].to_f) * 100).round(0)
  end

  def occupancy_percentage
    totals = resources_totals
    return 0 if totals[:total_units].to_i <= 0
    used = totals[:total_units] - totals[:available_units]
    ((used.to_f / totals[:total_units].to_f) * 100).round(0)
  end
end
