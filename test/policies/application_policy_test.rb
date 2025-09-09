require "test_helper"

class ApplicationPolicyTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @record = Object.new # Replace with a valid record object if needed
    @policy = ApplicationPolicy.new(@user, @record)
  end

  test "index? returns false" do
    assert_not @policy.index?
  end

  test "show? returns false" do
    assert_not @policy.show?
  end

  test "create? returns false" do
    assert_not @policy.create?
  end

  test "new? delegates to create?" do
    assert_equal @policy.create?, @policy.new?
  end

  test "update? returns false" do
    assert_not @policy.update?
  end

  test "edit? delegates to update?" do
    assert_equal @policy.update?, @policy.edit?
  end

  test "destroy? returns false" do
    assert_not @policy.destroy?
  end

  test "Scope#resolve raises NoMethodError" do
    scope = ApplicationPolicy::Scope.new(@user, @record)
    assert_raises(NoMethodError) { scope.resolve }
  end
end
