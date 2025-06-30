require "test_helper"

class ApplicationMailerTest < ActionMailer::TestCase
  test "default from email is set correctly" do
    mail = ApplicationMailer.new
    assert_equal "from@example.com", mail.default[:from], "Default from email should be set to from@example.com"
  end

  test "layout is set to mailer" do
    mail = ApplicationMailer.new
    assert_equal "mailer", mail.class.default[:layout], "Layout should be set to mailer"
  end
end
