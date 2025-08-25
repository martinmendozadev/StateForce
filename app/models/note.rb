class Note < ApplicationRecord
  belongs_to :creator_user, class_name: "User"

  has_many :operational_unit_notes, dependent: :destroy
  has_many :operational_units, through: :operational_unit_notes

  has_many :event_notes, dependent: :destroy
  has_many :events, through: :event_notes

  has_many :note_editors, dependent: :destroy
  has_many :editors, through: :note_editors, source: :user

  has_many :resource_notes, dependent: :destroy
  has_many :resources, through: :resource_notes

  has_many :institution_notes, dependent: :destroy
  has_many :institutions, through: :institution_notes

  # Enums
  enum :visibility, {
    public: "public",
    private: "private",
    restricted: "restricted"
  }, prefix: true

  # Validations
  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true
  validates :visibility, presence: true, inclusion: { in: visibilities.keys }
end
