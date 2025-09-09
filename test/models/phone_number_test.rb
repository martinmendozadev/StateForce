require "test_helper"

class PhoneNumberTest < ActiveSupport::TestCase
  def setup
    @phone = phone_numbers(:one)
  end

  test "should be valid with valid attributes" do
    assert @phone.valid?
  end

  test "should require number" do
    @phone.number = nil
    assert_not @phone.valid?
  end

  test "should not allow number longer than 25 characters" do
    @phone.number = "1" * 26
    assert_not @phone.valid?
  end

  test "should not allow extension longer than 3 characters" do
    @phone.extension = "1" * 4
    assert_not @phone.valid?
  end

  test "should default to personal type" do
    phone = PhoneNumber.new(number: "526641401806")
    assert phone.phone_type_personal?
  end
end
