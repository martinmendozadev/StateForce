require "test_helper"

class InstitutionAttachmentTest < ActiveSupport::TestCase
  def setup
    @institution_attachment = institution_attachments(:one)
  end

  test "fixture is valid" do
    assert @institution_attachment.valid?
  end

  test "should require institution_id" do
    @institution_attachment.institution_id = nil
    assert_not @institution_attachment.valid?
  end

  test "should require attachment_id" do
    @institution_attachment.attachment_id = nil
    assert_not @institution_attachment.valid?
  end

  test "composite key should enforce uniqueness" do
    duplicate = InstitutionAttachment.new(
      institution: @institution_attachment.institution,
      attachment: @institution_attachment.attachment
    )
    assert_raises ActiveRecord::RecordNotUnique do
      duplicate.save(validate: false)
    end
  end
end
