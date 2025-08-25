class Attachment < ApplicationRecord
  belongs_to :uploader_user, class_name: "User"

  has_many :institution_attachments, dependent: :destroy
  has_many :institutions, through: :institution_attachments

  has_many :operational_units_attachments, dependent: :destroy
  has_many :operational_units, through: :operational_units_attachments

  enum :file_type, {
    certification: "certification",
    document: "document",
    image: "image",
    other: "other",
    video: "video"
  }, prefix: true # => e.g., file_type_document?

  enum :visibility, {
    public: "public",
    private: "private",
    restricted: "restricted"
  }, prefix: true # => e.g., visibility_private?

  validates :file_url, presence: true
  validates :file_type, presence: true, inclusion: { in: file_types.keys }
  validates :visibility, presence: true, inclusion: { in: visibilities.keys }
  validates :file_name, length: { maximum: 75 }, allow_blank: true
  validates :content_type, length: { maximum: 25 }, allow_blank: true
end
