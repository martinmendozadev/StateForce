# frozen_string_literal: true

require "test_helper"
require "faker"

class SignInTest < ActionDispatch::SystemTestCase
  def setup
    @user = users(:user_one)

    visit new_user_session_path
  end

  def teardown
    page.execute_script(%Q{
      fetch("#{destroy_user_session_path}", {method: "DELETE", credentials: "same-origin"});
    })
  end

  test "renders the sign-in page" do
    assert_selector "h2", text: I18n.t("devise.sessions.sign_in")
  end

  test "has link to return to home page" do
    assert_selector "a[href='#{root_path}']"
  end

  test "renders sign-in form elements" do
    assert_selector "form[action='#{user_session_path}'][method='post']"
    assert_selector "input[name='user[email]']"
    assert_selector "input[name='user[password]']"
    assert_selector "input[type='submit'][value='#{I18n.t("devise.sessions.sign_in") }']"
  end

  test "sign-in page shows Google sign-in button" do
    assert_selector "a[href='#{user_google_oauth2_omniauth_authorize_path}']"
  end

  test "sign-in page has link to sign-up page" do
    assert_text I18n.t("devise.sessions.create_account").strip
    assert_text I18n.t("devise.registrations.sign_up").strip
    assert_selector "a[href='#{new_user_registration_path}']"
  end

  test "user can sign in" do
    fill_in I18n.t("devise.registrations.email"), with: @user.email
    fill_in I18n.t("devise.registrations.password"), with: "password"
    click_on I18n.t("devise.sessions.sign_in")

    assert_current_path dashboard_path
  end

  test "user cannot sign in with invalid credentials" do
    fill_in I18n.t("devise.registrations.email"), with: @user.email
    fill_in I18n.t("devise.registrations.password"), with: "wrong_password"
    click_on I18n.t("devise.sessions.sign_in")

    assert_text I18n.t("devise.failure.invalid", authentication_keys: "Email")
  end

  test "user can sign in with Google" do
    mock_google_auth(email: "user2@stateforce.mx", uid: "1234567890", name: "User 2 Last")
    visit new_user_session_path
    click_on I18n.t("devise.providers.google")
    assert_current_path dashboard_path
    assert_text "user2@stateforce.mx"
  end
end
