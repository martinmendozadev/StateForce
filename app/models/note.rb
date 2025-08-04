class Note < ApplicationRecord
   belongs_to :creator_user, class_name: "User"

  enum :visibility, {
    public: "public",
    private: "private",
    restricted: "restricted"
  }, prefix: true

  validates :title, presence: true, length: { maximum: 100 }
  validates :body, presence: true
  validates :visibility, presence: true, inclusion: { in: visibilities.keys }
end
