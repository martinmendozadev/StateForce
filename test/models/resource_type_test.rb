require "test_helper"

class ResourceTypeTest < ActiveSupport::TestCase
  def setup
    @category = resource_categories(:one)
    @resource_type = resource_types(:one)
  end

  test "should be valid with valid attributes" do
    assert @resource_type.valid?
  end

  test "should require name" do
    @resource_type.name = nil
    assert_not @resource_type.valid?
  end

  test "should not allow duplicate names within the same category" do
    duplicate = @resource_type.dup
    duplicate.resource_category = @resource_type.resource_category
    assert_not duplicate.valid?
  end

  test "should allow same name in different categories" do
    other_category = resource_categories(:one)
    duplicate = @resource_type.dup
    duplicate.resource_category = other_category
    duplicate.id = 1000
    assert duplicate.valid?
  end
end
