require "test_helper"

class BedInventoryTest < ActiveSupport::TestCase
  def setup
    @inventory = bed_inventories(:one)
  end

  test "should be valid" do
    assert @inventory.valid?
  end

  test "should require bed_type" do
    @inventory.bed_type = nil
    assert_not @inventory.valid?
  end

  test "should not allow available > total" do
    @inventory.total = 2
    @inventory.available = 5
    assert_not @inventory.valid?
  end

  test "default values should be set" do
    new_inv = BedInventory.new(bed_type: "general", operational_unit: operational_units(:two))
    assert_equal 0, new_inv.available
    assert_equal 0, new_inv.total
  end
end
