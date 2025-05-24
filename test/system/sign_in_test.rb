# frozen_string_literal: true

require "test_helper"
require "faker"

class SignInTest < ActionDispatch::SystemTestCase
  def setup
    @user = users(:user_one)
  end

  test "user can sign in" do
    visit new_user_session_path

    fill_in I18n.t("devise.registrations.email"), with: @user.email
    fill_in I18n.t("devise.registrations.password"), with: "password"
    click_on I18n.t("devise.sessions.sign_in")

    assert_current_path dashboard_path
  end

  test "user cannot sign in with invalid credentials" do
    visit new_user_session_path

    fill_in I18n.t("devise.registrations.email"), with: @user.email
    fill_in I18n.t("devise.registrations.password"), with: "wrong_password"
    click_on I18n.t("devise.sessions.sign_in")

    assert_text I18n.t("devise.failure.invalid", authentication_keys: "Email")
    # assert_text "Invalid Email or password."
  end
end
