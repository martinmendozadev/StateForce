require "test_helper"

class MedicalCenterProfileTest < ActiveSupport::TestCase
  def setup
    @profile = medical_center_profiles(:one)
  end

  test "should be valid" do
    assert @profile.valid?
  end

  test "should require valid level" do
    assert_raises(ArgumentError) { @profile.level = "invalid" }
  end

  test "should not allow available > total rooms" do
    @profile.operating_rooms_total = 2
    @profile.operating_rooms_available = 5
    assert_not @profile.valid?
  end

  test "default values should be set" do
    new_profile = MedicalCenterProfile.new(operational_unit: operational_units(:one))
    assert_equal false, new_profile.external_pharmacy_available
    assert_equal false, new_profile.internal_pharmacy_available
    assert_equal "unknown", new_profile.level
    assert_equal 0, new_profile.operating_rooms_total
    assert_equal 0, new_profile.operating_rooms_available
  end
end
