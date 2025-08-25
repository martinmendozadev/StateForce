require "test_helper"

class EventTest < ActiveSupport::TestCase
  test "valid factory" do
    assert events(:one).valid?
  end

  test "invalid without event_type" do
    event = Event.new(priority_level: "high", status: "pending", reported_time: Time.current)
    assert event.valid?
  end
end
