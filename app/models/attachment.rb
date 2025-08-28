class Attachment < ApplicationRecord
  # Associations
  belongs_to :uploader_user, class_name: "User"
  belongs_to :attachable, polymorphic: true

  # Enums
  enum :file_type, {
    certification: "certification",
    document: "document",
    image: "image",
    other: "other",
    video: "video"
  }, prefix: true

  enum :visibility, {
    public: "public",
    private: "private",
    restricted: "restricted"
  }, prefix: true

  # Validations
  validates :file_url, presence: true
  validates :file_name, length: { maximum: 75 }, allow_blank: true
  validates :content_type, length: { maximum: 25 }, allow_blank: true
  validates :file_type, presence: true, inclusion: { in: file_types.keys }
  validates :visibility, presence: true, inclusion: { in: visibilities.keys }
end
