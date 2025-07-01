# frozen_string_literal: true

require "test_helper"
require "faker"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  def setup
    @user =  {
      password: Faker::Internet.password(min_length: 8, max_length: 20),
      email: Faker::Internet.email
    }

    visit new_user_registration_path
  end

  test "user can access the sign-up page" do
    assert_selector "h2", text: I18n.t("devise.registrations.sign_up")
  end

  test "user can return to index page" do
    assert_selector "a[href='#{root_path}']"
  end

  test "user can see the sign-up form elements" do
    assert_selector "form[action='#{user_registration_path}'][method='post']"
    assert_selector "input[name='user[email]']"
    assert_selector "input[name='user[password]']"
    assert_selector "input[name='user[password_confirmation]']"
    assert_selector "input[type='submit'][value='#{I18n.t("devise.registrations.sign_up_button") }']"
  end

  test "user can see google sign-up button" do
    assert_selector "a[href='#{user_google_oauth2_omniauth_authorize_path}']"
  end

  test "sign-up page has link to sign-in page" do
    assert_text I18n.t("devise.registrations.already_have_account").strip
    assert_text I18n.t("devise.registrations.sign_in").strip

    assert_selector "a[href='#{new_user_session_path}']"
  end

  test "user cannot sign up with mismatched passwords" do
    fill_in I18n.t("devise.registrations.email"),  with: @user[:email]
    fill_in I18n.t("devise.registrations.password"), with: @user[:password]
    fill_in I18n.t("devise.registrations.password_confirmation"), with: "mismatched_password"
    click_on I18n.t("devise.registrations.sign_up_button")

    assert_text "Password confirmation doesn't match Password"
  end

  test "user can sign up with email and password successfully" do
    fill_in I18n.t("devise.registrations.email"), with: @user[:email]
    fill_in I18n.t("devise.registrations.password"), with: @user[:password]
    fill_in I18n.t("devise.registrations.password_confirmation"), with: @user[:password]
    click_on I18n.t("devise.registrations.sign_up_button")

    assert_current_path users_instructions_path
    log_out User.new(@user)
  end

  test "user can sign up with Google" do
    mock_google_auth(email: @user[:email])
    visit new_user_registration_path
    click_on I18n.t("devise.providers.google")

    assert_current_path dashboard_path
    assert_text @user[:email]
    log_out User.new(@user)
  end
end
