require "test_helper"

class UserNoteTest < ActiveSupport::TestCase
  def setup
    @user_note = user_notes(:one)
  end

  test "fixture is valid" do
    assert @user_note.valid?
  end

  test "should require user_id" do
    @user_note.user_id = nil
    assert_not @user_note.valid?
  end

  test "should require note_id" do
    @user_note.note_id = nil
    assert_not @user_note.valid?
  end

  test "starred must be true or false" do
    assert_includes [ true, false ], @user_note.starred
  end

  test "scope starred should return only starred notes" do
    assert_includes UserNote.starred, user_notes(:one)
    refute_includes UserNote.starred, user_notes(:two)
  end

  test "composite key should enforce uniqueness" do
    duplicate = UserNote.new(user: @user_note.user, note: @user_note.note)
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
