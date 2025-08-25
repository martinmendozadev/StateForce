require "test_helper"

class OperationalUnitsAttachmentTest < ActiveSupport::TestCase
  def setup
    @unit_attachment = operational_units_attachments(:one)
  end

  test "fixture is valid" do
    assert @unit_attachment.valid?
  end

  test "should require operational_unit_id" do
    @unit_attachment.operational_unit_id = nil
    assert_not @unit_attachment.valid?
  end

  test "should require attachment_id" do
    @unit_attachment.attachment_id = nil
    assert_not @unit_attachment.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = OperationalUnitsAttachment.new(
      operational_unit: @unit_attachment.operational_unit,
      attachment: @unit_attachment.attachment
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
