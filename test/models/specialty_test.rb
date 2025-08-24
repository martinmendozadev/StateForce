require "test_helper"

class SpecialtyTest < ActiveSupport::TestCase
  def setup
    @specialty = specialties(:one)
  end

  test "should be valid" do
    assert @specialty.valid?
  end

  test "name should be present" do
    @specialty.name = nil
    assert_not @specialty.valid?
  end

  test "name should not be too long" do
    @specialty.name = "A" * 151
    assert_not @specialty.valid?
  end

  test "code should be unique" do
    duplicate = @specialty.dup
    duplicate.name = "Different Name"
    assert_not duplicate.valid?
  end

  test "description can be blank" do
    @specialty.description = nil
    assert @specialty.valid?
  end
end
