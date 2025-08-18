class Location < ApplicationRecord
  attr_accessor :longitude, :latitude

  ## Validations
  validates :address, length: { maximum: 150 }, allow_nil: true
  validates :place_name, length: { maximum: 100 }, allow_nil: true
  validates :coordinates, presence: true

  validate :coordinates_format
  before_validation :set_coordinates_from_lon_lat, if: -> { longitude.present? || latitude.present? }


  private

  def set_coordinates_from_lon_lat
    return unless longitude.present? && latitude.present?

    lon = longitude.to_f
    lat = latitude.to_f

    unless within_lon_lat_bounds?(lon, lat)
      errors.add(:coordinates, I18n.t("errors.messages.invalid_coordinates"))
      return
    end

    factory = RGeo::Geographic.spherical_factory(srid: 4326)
    self.coordinates = factory.point(lon, lat)
  end

  def within_lon_lat_bounds?(lon, lat)
    lon.is_a?(Numeric) && lat.is_a?(Numeric) && (-180..180).include?(lon) && (-90..90).include?(lat)
  end

  def coordinates_format
    return if coordinates.nil?

    if coordinates.is_a?(RGeo::Feature::Point)
      lon = coordinates.x
      lat = coordinates.y
      unless within_lon_lat_bounds?(lon, lat)
        errors.add(:coordinates, I18n.t("errors.messages.invalid_coordinates"))
      end
    else
      errors.add(:coordinates, I18n.t("errors.messages.wrong_coordinates"))
    end
  end
end
