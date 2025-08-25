require "test_helper"

class InviteTest < ActiveSupport::TestCase
  def setup
    @invite = invites(:one)
  end

  test "should be valid with valid attributes" do
    assert @invite.valid?
  end

  test "should require email" do
    @invite.email = nil
    assert_not @invite.valid?
  end

  test "should require valid email format" do
    @invite.email = "invalid_email"
    assert_not @invite.valid?
  end

  test "should require unique token" do
    duplicate = @invite.dup
    assert_not duplicate.valid?
  end

  test "should require expires_at" do
    @invite.expires_at = nil
    assert_not @invite.valid?
  end
end
