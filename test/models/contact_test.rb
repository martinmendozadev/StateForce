require "test_helper"

class ContactTest < ActiveSupport::TestCase
  def setup
    @contact = contacts(:one)
  end

  test "should be valid with valid attributes" do
    assert @contact.valid?
  end

  test "should require email" do
    @contact.email = nil
    assert_not @contact.valid?
  end

  test "should enforce unique email" do
    duplicate = @contact.dup
    assert_not duplicate.valid?
  end

  test "should validate email format" do
    @contact.email = "invalid-email"
    assert_not @contact.valid?
  end

  test "should allow blank name and radio_frequency" do
    @contact.name = nil
    @contact.radio_frequency = nil
    assert @contact.valid?
  end
end
