require "test_helper"

class LocationTest < ActiveSupport::TestCase
  def setup
    @location = locations(:one)
  end

  test "should be valid with valid attributes" do
    assert @location.valid?
  end

  test "should not be valid without coordinates" do
    @location.coordinates = nil
    assert_not @location.valid?
    assert_includes @location.errors[:coordinates], "can't be blank"
  end

  test "coordinates should be a valid geographic point" do
    @location.longitude = 200
    @location.latitude = 100
    assert_not @location.valid?
    assert_includes @location.errors[:coordinates], I18n.t("errors.messages.invalid_coordinates")
  end

  test "address should be at most 150 characters" do
    @location.address = "a" * 151
    assert_not @location.valid?
  end

  test "place_name should be at most 100 characters" do
    @location.place_name = "a" * 101
    assert_not @location.valid?
  end
end
