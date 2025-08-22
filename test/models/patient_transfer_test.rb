require "test_helper"

class PatientTransferTest < ActiveSupport::TestCase
  def setup
    @transfer = patient_transfers(:one)
  end

  test "should be valid" do
    assert @transfer.valid?
  end

  test "should require status" do
    @transfer.status = nil
    assert_not @transfer.valid?
  end

  test "status should be in allowed values" do
    assert_raises(ArgumentError) { @transfer.status = "invalid_status" }
  end

  test "arrival_time must be after departure_time" do
    @transfer.departure_time = Time.current
    @transfer.arrival_time = 1.hour.ago
    assert_not @transfer.valid?
  end
end
