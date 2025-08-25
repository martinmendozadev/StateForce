require "test_helper"

class ResourceNoteTest < ActiveSupport::TestCase
  def setup
    @resource_note = resource_notes(:one)
  end

  test "fixture is valid" do
    assert @resource_note.valid?
  end

  test "should require resource_id" do
    @resource_note.resource_id = nil
    assert_not @resource_note.valid?
  end

  test "should require note_id" do
    @resource_note.note_id = nil
    assert_not @resource_note.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = ResourceNote.new(resource: @resource_note.resource, note: @resource_note.note)
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
