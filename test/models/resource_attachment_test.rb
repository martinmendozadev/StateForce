require "test_helper"

class ResourceAttachmentTest < ActiveSupport::TestCase
  def setup
    @resource_attachment = resource_attachments(:one)
  end

  test "fixture is valid" do
    assert @resource_attachment.valid?
  end

  test "should require resource_id" do
    @resource_attachment.resource_id = nil
    assert_not @resource_attachment.valid?
  end

  test "should require attachment_id" do
    @resource_attachment.attachment_id = nil
    assert_not @resource_attachment.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = ResourceAttachment.new(
      resource: @resource_attachment.resource,
      attachment: @resource_attachment.attachment
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
