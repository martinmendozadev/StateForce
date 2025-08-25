class Institution < ApplicationRecord
  ## Relationships
  belongs_to :location
  belongs_to :director, class_name: "User", optional: true
  belongs_to :parent_institution, class_name: "Institution", optional: true

  has_many :event_institutions, dependent: :destroy
  has_many :events, through: :event_institutions

  has_many :institution_contacts, dependent: :destroy
  has_many :contacts, through: :institution_contacts

  has_many :institution_attachments, dependent: :destroy
  has_many :attachments, through: :institution_attachments

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
  validates :name, presence: true, uniqueness: true, length: { maximum: 150 }
  validates :callsign, uniqueness: true, allow_nil: true, length: { maximum: 50 }
end
