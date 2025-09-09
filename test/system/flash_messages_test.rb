# frozen_string_literal: true

require "test_helper"

class FlashMessagesTest < ActionDispatch::SystemTestCase
  def setup
    @user = users(:one)
    log_out @user

    visit new_user_session_path
  end

  def teardown
    log_out @user
  end

  test "flash message appears and disappears after X seconds" do
    wrong_login

    assert_selector "#flash-messages .mb-2", visible: true
    assert_no_selector "#flash-messages .mb-2", visible: true, wait: GLOBAL_VARS[:flash_messages_disappeared_after] + 1
  end

  test "flash message can be closed manually" do
    wrong_login

    assert_selector "#flash-messages .mb-2", visible: true
    find("#flash-messages button[aria-label]").click
    assert_no_selector "#flash-messages .mb-2", visible: true, wait: 1
  end

  test "flash message for notice has correct color classes" do
    mock_google_auth
    click_on I18n.t("devise.providers.google")

    assert_selector "#flash-messages .bg-info.border-info-focus.text-info-content", visible: true
  end

  test "flash message for alert has correct color classes" do
    wrong_login

    assert_selector "#flash-messages .bg-danger.border-danger-focus.text-danger-content", visible: true
  end

  test "flash message for error has correct color classes" do
    wrong_login

    assert_selector "#flash-messages .bg-danger.border-danger-focus.text-danger-content", visible: true
  end

  private
  def wrong_login
    fill_in I18n.t("devise.registrations.email"), with: @user.email
    fill_in I18n.t("devise.registrations.password"), with: "wrong_password"
    click_on I18n.t("devise.sessions.sign_in")
  end
end
