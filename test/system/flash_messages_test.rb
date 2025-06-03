# frozen_string_literal: true

require "test_helper"
require "faker"

class FlashMessagesTest < ActionDispatch::SystemTestCase
  def setup
    @user = users(:user_one)

    visit new_user_session_path
  end

  def teardown
    page.execute_script(%Q{
      fetch("#{destroy_user_session_path}", {method: "DELETE", credentials: "same-origin"});
    })
  end

  test "flash message appears and disappears after X seconds" do
    wrong_login

    assert_selector "#flash-messages .mb-2", visible: true
    assert_no_selector "#flash-messages .mb-2", visible: true, wait: GLOBAL_VARS[:flash_messages_disappeared_after] + 0.5
  end

  test "flash message can be closed manually" do
    wrong_login

    assert_selector "#flash-messages .mb-2", visible: true
    find("#flash-messages button[aria-label]").click
    assert_no_selector "#flash-messages .mb-2", visible: true, wait: 0.5
  end

  test "flash message for notice has correct color classes" do
    user_auth =  {
      email: Faker::Internet.email,
      uid: Faker::Number.number(digits: 10),
      name: Faker::Name.name
    }
    mock_google_auth(email: user_auth[:email], uid: user_auth[:uid], name: user_auth[:name])
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
