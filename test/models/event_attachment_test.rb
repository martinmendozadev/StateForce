require "test_helper"

class EventAttachmentTest < ActiveSupport::TestCase
  def setup
    @event_attachment = event_attachments(:one)
  end

  test "fixture is valid" do
    assert @event_attachment.valid?
  end

  test "should require event_id" do
    @event_attachment.event_id = nil
    assert_not @event_attachment.valid?
  end

  test "should require attachment_id" do
    @event_attachment.attachment_id = nil
    assert_not @event_attachment.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = EventAttachment.new(
      event: @event_attachment.event,
      attachment: @event_attachment.attachment
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
