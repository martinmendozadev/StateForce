require "test_helper"

class ScheduleEntryTest < ActiveSupport::TestCase
  def setup
    @entry = schedule_entries(:one)
  end

  test "should be valid with valid attributes" do
    assert @entry.valid?
  end

  test "should require title" do
    @entry.title = nil
    assert_not @entry.valid?
  end

  test "should not allow title longer than 100 characters" do
    @entry.title = "a" * 101
    assert_not @entry.valid?
  end

  test "should default to pending status" do
    entry = ScheduleEntry.new(title: "Test", creator_user: users(:one))
    assert entry.status_pending?
  end
end
