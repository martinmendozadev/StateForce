class Note < ApplicationRecord
  # Associations
  belongs_to :creator_user, class_name: "User"

  belongs_to :noteable, polymorphic: true

  has_many :note_editors, dependent: :destroy
  has_many :editors, through: :note_editors, source: :user

  # Enums
  enum :visibility, {
    public: "public",
    private: "private",
    restricted: "restricted"
  }, prefix: true

  # Validations
  validates :body, presence: true
  validates :title, presence: true, length: { maximum: 100 }
  validates :visibility, presence: true, inclusion: { in: visibilities.keys }
end
