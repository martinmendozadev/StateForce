# frozen_string_literal: true

class Attachment < ApplicationRecord
  include Enums

  # Associations
  belongs_to :attachable, polymorphic: true
  belongs_to :uploader_user, class_name: "User"

  # Enums
  enum :file_type, FILE_TYPES, prefix: true
  enum :visibility, VISIBILITIES, prefix: true

  # Validations
  validates :uploader_user, presence: true
  validates :attachable, presence: true

  validates :file_url,
            presence: true,
            format: { with: URI::DEFAULT_PARSER.make_regexp(%w[http https]),
                      message: I18n.t("attachment.errors.messages.not_a_url") }

  validates :file_name,
            presence: true,
            length: { maximum: 75 },
            format: { with: /\A[\w\s\-.]+\z/,
                      message: I18n.t("attachment.errors.messages.file_name_format") }

  validates :content_type,
            presence: true,
            length: { maximum: 25 },
            format: { with: %r{\A[\w\-/]+\z},
                      message: I18n.t("attachment.errors.messages.content_type_format") }

  validates :file_size,
            numericality: { only_integer: true, greater_than_or_equal_to: 0, allow_nil: true }

  validates :file_type,
            presence: true,
            inclusion: { in: file_types.keys }

  validates :visibility,
            presence: true,
            inclusion: { in: visibilities.keys }
end
