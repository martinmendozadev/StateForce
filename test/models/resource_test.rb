require "test_helper"

class ResourceTest < ActiveSupport::TestCase
  def setup
    @resource = resources(:one)
  end

  test "should be valid" do
    assert @resource.valid?
  end

  test "should require name" do
    @resource.name = nil
    assert_not @resource.valid?
  end

  test "should not allow duplicate name within institution" do
    duplicate = @resource.dup
    duplicate.institution = @resource.institution
    assert_not duplicate.valid?
  end

  test "available units cannot exceed total units" do
    @resource.available_units = 10
    @resource.total_units = 5
    assert_not @resource.valid?
  end
end
