require "test_helper"

class NoteTest < ActiveSupport::TestCase
  def setup
    @note = notes(:one)
  end

  test "should be valid with valid attributes" do
    assert @note.valid?
  end

  test "should require title" do
    @note.title = nil
    assert_not @note.valid?
  end

  test "should require body" do
    @note.body = nil
    assert_not @note.valid?
  end

  test "should not accept overly long title" do
    @note.title = "a" * 101
    assert_not @note.valid?
  end

  test "should require valid visibility" do
    assert_raises ArgumentError do
      @note.visibility = "invalid_option"
    end
  end
end
