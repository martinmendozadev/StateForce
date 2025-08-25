require "test_helper"

class PatientTransfersNoteTest < ActiveSupport::TestCase
  def setup
    @ptn = patient_transfers_notes(:one)
  end

  test "fixture is valid" do
    assert @ptn.valid?
  end

  test "should require patient_transfer_id" do
    @ptn.patient_transfer_id = nil
    assert_not @ptn.valid?
  end

  test "should require note_id" do
    @ptn.note_id = nil
    assert_not @ptn.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = PatientTransfersNote.new(
      patient_transfer: @ptn.patient_transfer,
      note: @ptn.note
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
