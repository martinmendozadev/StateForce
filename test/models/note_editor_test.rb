require "test_helper"

class NoteEditorTest < ActiveSupport::TestCase
  def setup
    @note_editor = note_editors(:one)
  end

  test "fixture is valid" do
    assert @note_editor.valid?
  end

  test "should require note_id" do
    @note_editor.note_id = nil
    assert_not @note_editor.valid?
  end

  test "should require user_id" do
    @note_editor.user_id = nil
    assert_not @note_editor.valid?
  end

  test "should require last_edited_at" do
    @note_editor.last_edited_at = nil
    assert_not @note_editor.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = NoteEditor.new(note: @note_editor.note, user: @note_editor.user)
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
