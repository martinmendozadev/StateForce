require "test_helper"

class InstitutionTest < ActiveSupport::TestCase
  test "valid factory" do
    assert institutions(:one).valid?
  end

  test "invalid without name" do
    institution = Institution.new
    assert_not institution.valid?
    assert_includes institution.errors[:name], "can't be blank"
  end
end
