require "test_helper"

class EventTest < ActiveSupport::TestCase
  def setup
    @event = events(:one)
    @other = events(:two)
  end

  test "fixture is valid" do
    assert @event.valid?
    assert @other.valid?
  end

  test "reported_time presence is required" do
    event = Event.new(event_type: "emergency", priority_level: "high", status: "pending")
    assert_not event.valid?
    assert_includes event.errors[:reported_time], "can't be blank"
  end

  test "event_code length and uniqueness validations" do
    long_code = "x" * 51
    event = Event.new(event_type: "emergency", priority_level: "high", status: "pending", reported_time: Time.current, event_code: long_code)
    assert_not event.valid?
    assert_includes event.errors[:event_code], "is too long (maximum is 50 characters)"

  # uniqueness
  _first = Event.create!(event_type: "other", priority_level: "low", status: "pending", reported_time: Time.current, event_code: "UNIQCODE")
    dup = Event.new(event_type: "other", priority_level: "low", status: "pending", reported_time: Time.current, event_code: "UNIQCODE")
    assert_not dup.valid?
    assert_includes dup.errors[:event_code], "has already been taken"
  end

  test "reported_by_text length validation" do
    event = Event.new(event_type: "emergency", priority_level: "high", status: "pending", reported_time: Time.current, reported_by_text: "x" * 151)
    assert_not event.valid?
    assert_includes event.errors[:reported_by_text], "is too long (maximum is 150 characters)"
  end

  test "people_affected must be integer and non-negative" do
    event = Event.new(event_type: "emergency", priority_level: "high", status: "pending", reported_time: Time.current)
    event.people_affected = -1
    assert_not event.valid?
    assert_includes event.errors[:people_affected], "must be greater than or equal to 0"

    event.people_affected = 1.5
    assert_not event.valid?
    assert_includes event.errors[:people_affected], "must be an integer"
  end

  test "enum predicate methods and prefixes work" do
    assert @event.event_type_emergency?
    assert @event.priority_level_high?
    assert @event.status_pending?
  end

  test "location association is optional" do
    event = Event.new(event_type: "emergency", priority_level: "high", status: "pending", reported_time: Time.current)
    assert event.valid?
  end
end
