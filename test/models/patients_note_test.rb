require "test_helper"

class PatientsNoteTest < ActiveSupport::TestCase
  def setup
    @pn = patients_notes(:one)
  end

  test "fixture is valid" do
    assert @pn.valid?
  end

  test "should require patient_id" do
    @pn.patient_id = nil
    assert_not @pn.valid?
  end

  test "should require note_id" do
    @pn.note_id = nil
    assert_not @pn.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = PatientsNote.new(
      patient: @pn.patient,
      note: @pn.note
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
