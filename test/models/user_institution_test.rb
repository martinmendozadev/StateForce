require "test_helper"

class UserInstitutionTest < ActiveSupport::TestCase
  def setup
    @user_institution = user_institutions(:one)
  end

  test "should be valid" do
    assert @user_institution.valid?
  end

  test "should require a role" do
    @user_institution.role = nil
    assert_not @user_institution.valid?
  end

  test "should require a status" do
    @user_institution.status = nil
    assert_not @user_institution.valid?
  end

  test "should not allow position longer than 50 chars" do
    @user_institution.position = "A" * 51
    assert_not @user_institution.valid?
  end

  test "should enforce composite key uniqueness" do
    duplicate = @user_institution.dup
    duplicate.user = @user_institution.user
    duplicate.institution = @user_institution.institution
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
