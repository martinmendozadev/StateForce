require "test_helper"

class AuditLogTest < ActiveSupport::TestCase
  def setup
    @log = audit_logs(:one)
  end

  test "should be valid" do
    assert @log.valid?
  end

  test "should require action" do
    @log.action = nil
    assert_not @log.valid?
  end

  test "should require valid action" do
    assert_raises(ArgumentError) { @log.action = "invalid_action" }
  end

  test "should require entity_id" do
    @log.entity_id = nil
    assert_not @log.valid?
  end

  test "should require valid entity_name" do
    assert_raises(ArgumentError) { @log.entity_name = "invalid_entity" }
  end
end
