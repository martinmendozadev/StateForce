require "test_helper"

class UserCallsignTest < ActiveSupport::TestCase
  def setup
    @callsign = user_callsigns(:one)
  end

  test "should be valid" do
    assert @callsign.valid?
  end

  test "should require callsign" do
    @callsign.callsign = nil
    assert_not @callsign.valid?
  end

  test "callsign should not be too long" do
    @callsign.callsign = "A" * 51
    assert_not @callsign.valid?
  end

  test "should enforce uniqueness within the same institution" do
    duplicate = @callsign.dup
    assert_not duplicate.valid?
  end

  test "same callsign can exist in different institutions" do
    other_inst = institutions(:three)
    duplicate = @callsign.dup
    duplicate.institution = other_inst
    assert duplicate.valid?
  end
end
