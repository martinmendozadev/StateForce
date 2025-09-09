require "test_helper"

class ContactPhoneNumberTest < ActiveSupport::TestCase
  def setup
    @cpn = contact_phone_numbers(:one)
  end

  test "fixture is valid" do
    assert @cpn.valid?
  end

  test "should require contact_id" do
    @cpn.contact_id = nil
    assert_not @cpn.valid?
  end

  test "should require phone_number_id" do
    @cpn.phone_number_id = nil
    assert_not @cpn.valid?
  end

  test "is_primary must be true or false" do
    assert_includes [ true, false ], @cpn.is_primary
  end

  test "scope primary should return only primaries" do
    assert_includes ContactPhoneNumber.primary, contact_phone_numbers(:one)
    refute_includes ContactPhoneNumber.primary, contact_phone_numbers(:two)
  end

  test "composite key should enforce uniqueness" do
    duplicate = ContactPhoneNumber.new(
      contact: @cpn.contact,
      phone_number: @cpn.phone_number
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
