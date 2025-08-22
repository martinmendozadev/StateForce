require "test_helper"

class ResourceCategoryTest < ActiveSupport::TestCase
  def setup
    @category = resource_categories(:one)
  end

  test "should be valid with valid attributes" do
    assert @category.valid?
  end

  test "should require name" do
    @category.name = nil
    assert_not @category.valid?
  end

  test "should require unique name" do
    duplicate = @category.dup
    assert_not duplicate.valid?
  end

  test "should not allow name longer than 150 characters" do
    @category.name = "a" * 151
    assert_not @category.valid?
  end
end
