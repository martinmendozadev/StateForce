# frozen_string_literal: true

require "test_helper"

class InstructionsTest < ActionDispatch::SystemTestCase
  test "instructions page shows logo, title, description and back to login link" do
    visit users_instructions_path

    assert_selector "img.h-16"

    assert_text I18n.t("instructions.title")

    assert_text I18n.t("instructions.description")

    assert_selector "a[href='#{new_user_session_path}']", text: I18n.t("instructions.back_to_login")
  end
end
