require "test_helper"

class PatientVitalTest < ActiveSupport::TestCase
  def setup
    @patient_vital = patient_vitals(:one)
  end

  test "should be valid with valid attributes" do
    assert @patient_vital.valid?
  end

  test "should require patient" do
    @patient_vital.patient = nil
    assert_not @patient_vital.valid?
  end

  test "should require recorded_by_user" do
    @patient_vital.recorded_by_user = nil
    assert_not @patient_vital.valid?
  end

  test "should validate ranges for vitals" do
    @patient_vital.heart_rate = 600
    assert_not @patient_vital.valid?

    @patient_vital.heart_rate = 80
    assert @patient_vital.valid?
  end
end
