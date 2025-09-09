require "test_helper"

class EventInstitutionTest < ActiveSupport::TestCase
  def setup
    @ei = event_institutions(:one)
  end

  test "fixture is valid" do
    assert @ei.valid?
  end

  test "requires event and institution" do
    record = EventInstitution.new
    assert_not record.valid?
    assert_includes record.errors.attribute_names, :event
    assert_includes record.errors.attribute_names, :institution
  end

  test "enforces uniqueness of [event_id, institution_id]" do
    dup = EventInstitution.new(
      event: @ei.event,
      institution: @ei.institution
    )
    assert_not dup.valid?
    assert_includes dup.errors.full_messages.join, "has already been taken"
  end
end
