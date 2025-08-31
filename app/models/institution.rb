# frozen_string_literal: true

class Institution < ApplicationRecord
  ## Relationships
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

  ## Enums
  enum :sector_type, {
    public: "public",
    private: "private",
    social: "social",
    unknown: "unknown"
  }, prefix: true

  enum :status, {
    available: "available",
    maintenance: "maintenance",
    out_of_service: "out_of_service"
  }, prefix: true

  ## Validations
  validates :location, presence: true
  validates :status, presence: true, inclusion: { in: statuses.keys }
  validates :name, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :sector_type, presence: true, inclusion: { in: sector_types.keys }
  validates :callsign, uniqueness: true, allow_nil: true, length: { maximum: 50 }
end
