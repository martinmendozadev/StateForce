class Note < ApplicationRecord
   belongs_to :creator_user, class_name: "User"

  has_many :operational_unit_notes, dependent: :destroy
  has_many :operational_units, through: :operational_unit_notes

  has_many :event_notes, dependent: :destroy
  has_many :events, through: :event_notes

  enum :visibility, {
    public: "public",
    private: "private",
    restricted: "restricted"
  }, prefix: true

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true
  validates :visibility, presence: true, inclusion: { in: visibilities.keys }
end
