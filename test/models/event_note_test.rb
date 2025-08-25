require "test_helper"

class EventNoteTest < ActiveSupport::TestCase
  def setup
    @event_note = event_notes(:one)
  end

  test "fixture is valid" do
    assert @event_note.valid?
  end

  test "should require event_id" do
    @event_note.event_id = nil
    assert_not @event_note.valid?
  end

  test "should require note_id" do
    @event_note.note_id = nil
    assert_not @event_note.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = EventNote.new(
      event: @event_note.event,
      note: @event_note.note
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
