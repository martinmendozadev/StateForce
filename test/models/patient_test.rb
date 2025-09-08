require "test_helper"

class PatientTest < ActiveSupport::TestCase
  def setup
    @event = events(:one)
    @patient = patients(:one)
  end

  test "should be valid with valid attributes" do
    assert @patient.valid?
  end

  test "should require name" do
    @patient.name = nil
    assert_not @patient.valid?
  end

  test "should not allow name longer than 100 chars" do
    @patient.name = "a" * 101
    assert_not @patient.valid?
  end

  test "should require age between 0 and 125" do
    @patient.age = -1
    assert_not @patient.valid?
    @patient.age = 130
    assert_not @patient.valid?
  end

  test "should require valid gender enum" do
    assert_raises(ArgumentError) { @patient.gender = "invalid" }
  end

  test "should require valid triage_status enum" do
    assert_raises(ArgumentError) { @patient.triage_status = "invalid" }
  end
end
