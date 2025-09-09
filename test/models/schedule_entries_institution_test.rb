require "test_helper"

class ScheduleEntriesInstitutionTest < ActiveSupport::TestCase
  def setup
    @sei = schedule_entries_institutions(:one)
  end

  test "fixture is valid" do
    assert @sei.valid?
  end

  test "should require schedule_entry_id" do
    @sei.schedule_entry_id = nil
    assert_not @sei.valid?
  end

  test "should require institution_id" do
    @sei.institution_id = nil
    assert_not @sei.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = ScheduleEntriesInstitution.new(
      schedule_entry: @sei.schedule_entry,
      institution: @sei.institution
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
