require "test_helper"

class InstitutionNoteTest < ActiveSupport::TestCase
  def setup
    @institution_note = institution_notes(:one)
  end

  test "fixture is valid" do
    assert @institution_note.valid?
  end

  test "should require institution_id" do
    @institution_note.institution_id = nil
    assert_not @institution_note.valid?
  end

  test "should require note_id" do
    @institution_note.note_id = nil
    assert_not @institution_note.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = InstitutionNote.new(institution: @institution_note.institution, note: @institution_note.note)
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
