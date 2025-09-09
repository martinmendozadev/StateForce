# frozen_string_literal: true

module Enums
  FILE_TYPES = {
    certification: "certification",
    document:      "document",
    image:         "image",
    other:         "other",
    video:         "video"
  }.freeze

  VISIBILITIES = {
    public:     "public",
    private:    "private",
    restricted: "restricted"
  }.freeze
end
