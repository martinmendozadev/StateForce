require "test_helper"

class AttachmentTest < ActiveSupport::TestCase
  def setup
    @attachment = attachments(:one)
  end

  test "should be valid with valid attributes" do
    assert @attachment.valid?
  end

  test "should require file_url" do
    @attachment.file_url = nil
    assert_not @attachment.valid?
    assert_includes @attachment.errors[:file_url], "can't be blank"
  end

  test "should require valid file_type enum" do
    assert Attachment.file_types.include?(@attachment.file_type)
  end

  test "should require valid visibility enum" do
    assert Attachment.visibilities.include?(@attachment.visibility)
  end

  test "should not allow file_name longer than 75 characters" do
    @attachment.file_name = "a" * 76
    assert_not @attachment.valid?
    assert_includes @attachment.errors[:file_name], "is too long (maximum is 75 characters)"
  end

  test "should belong to uploader_user" do
    assert_not_nil @attachment.uploader_user
  end
end
