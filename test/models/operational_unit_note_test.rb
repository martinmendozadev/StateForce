# test/models/operational_unit_note_test.rb
require "test_helper"

class OperationalUnitNoteTest < ActiveSupport::TestCase
  def setup
    @oun = operational_unit_notes(:one)
  end

  test "fixture is valid" do
    assert @oun.valid?
  end

  test "requires operational_unit and note" do
    rec = OperationalUnitNote.new
    assert_not rec.valid?
    assert_includes rec.errors.attribute_names, :operational_unit
    assert_includes rec.errors.attribute_names, :note
  end

  test "enforces uniqueness of [operational_unit_id, note_id]" do
    dup = OperationalUnitNote.new(
      operational_unit: @oun.operational_unit,
      note: @oun.note
    )

    assert_not dup.valid?
    assert_includes dup.errors.full_messages.join, "has already been taken"
  end
end
