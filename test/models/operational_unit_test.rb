require "test_helper"

class OperationalUnitTest < ActiveSupport::TestCase
  def setup
    @unit = operational_units(:one)
  end

  test "should be valid" do
    assert @unit.valid?
  end

  test "should require name" do
    @unit.name = nil
    assert_not @unit.valid?
  end

  test "should enforce valid triage_status" do
    assert_raises(ArgumentError) { @unit.triage_status = "invalid" }
  end

  test "should enforce valid facility type" do
    assert_raises(ArgumentError) { @unit.facility_type = "invalid" }
  end
end
