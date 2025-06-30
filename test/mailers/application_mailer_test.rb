require "test_helper"

class ApplicationMailerTest < ActionMailer::TestCase
  test "default from email is set correctly" do
    assert_equal "from@example.com", ApplicationMailer.default[:from], "Default from email should be set to from@example.com"
  end

  test "layout is set to mailer" do
    assert_equal "mailer", ApplicationMailer.default[:layout], "Layout should be set to mailer"
  end
end
