require "test_helper"

class InstitutionContactTest < ActiveSupport::TestCase
  def setup
    @ic = institution_contacts(:one)
  end

  test "fixture is valid" do
    assert @ic.valid?
  end

  test "should require institution_id" do
    @ic.institution_id = nil
    assert_not @ic.valid?
  end

  test "should require contact_id" do
    @ic.contact_id = nil
    assert_not @ic.valid?
  end

  test "should require valid contact_type" do
    assert_raises ArgumentError do
      @ic.contact_type = "invalid_type"
    end
  end

  test "composite key should enforce uniqueness" do
    duplicate = InstitutionContact.new(
      institution: @ic.institution,
      contact: @ic.contact,
      contact_type: @ic.contact_type
    )
  assert_not duplicate.valid?
  assert_includes duplicate.errors[:contact_type], "has already been taken"
  end
end
