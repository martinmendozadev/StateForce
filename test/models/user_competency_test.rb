require "test_helper"

class UserCompetencyTest < ActiveSupport::TestCase
  def setup
    @user_competency = user_competencies(:one)
  end

  test "should be valid" do
    assert @user_competency.valid?
  end

  test "should require user_id" do
    @user_competency.user_id = nil
    assert_not @user_competency.valid?
  end

  test "should require competency_id" do
    @user_competency.competency_id = nil
    assert_not @user_competency.valid?
  end

  test "expiry_date should be in the future from today" do
    @user_competency.expiry_date = Date.today - 1.day
    assert_not @user_competency.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = @user_competency.dup
    duplicate.user_id = @user_competency.user_id
    duplicate.competency_id = @user_competency.competency_id
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
