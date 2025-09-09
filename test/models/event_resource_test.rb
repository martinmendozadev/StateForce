require "test_helper"

class EventResourceTest < ActiveSupport::TestCase
  def setup
    @er = event_resources(:one)
  end

  test "fixture is valid" do
    assert @er.valid?
  end

  test "requires event, resource, assigned_by_user" do
    er = EventResource.new
    assert_not er.valid?
    assert_includes er.errors.attribute_names, :event
    assert_includes er.errors.attribute_names, :resource
    assert_includes er.errors.attribute_names, :assigned_by_user
  end

  test "quantity_assigned must be greater than 0" do
    @er.quantity_assigned = 0
    assert_not @er.valid?
  end

  test "enforces uniqueness of [event_id, resource_id]" do
    dup = EventResource.new(
      event: @er.event,
      resource: @er.resource,
      assigned_by_user: @er.assigned_by_user
    )
    assert_not dup.valid?
    assert_includes dup.errors.full_messages.join, "has already been taken"
  end
end
