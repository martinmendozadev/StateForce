require "test_helper"

class UserContactTest < ActiveSupport::TestCase
  def setup
    @uc = user_contacts(:one)
  end

  test "fixture is valid" do
    assert @uc.valid?
  end

  test "should require user_id" do
    @uc.user_id = nil
    assert_not @uc.valid?
  end

  test "should require contact_id" do
    @uc.contact_id = nil
    assert_not @uc.valid?
  end

  test "should require valid contact_type" do
    assert_raises ArgumentError do
      @uc.contact_type = "invalid_type"
    end
  end

  test "composite key should enforce uniqueness" do
    duplicate = UserContact.new(
      user: @uc.user,
      contact: @uc.contact,
      contact_type: @uc.contact_type
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
