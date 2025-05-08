# frozen_string_literal: true

require "test_helper"

class UserSignInTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_one)
    @unconfirmed_user = users(:user_three)

    get new_user_session_path
    assert_response :success
  end

  test "renders the sign-in page" do
    assert_select "h2", I18n.t("devise.sessions.sign_in")

    assert_nil session["warden.user.user.key"]
  end

  test "has link to return to home page" do
    assert_select "a[href=?]", root_path
  end

  test "renders sign-in form elements" do
    assert_select "form[action=?][method=post]", user_session_path do
      assert_select "input[name=?]", "user[email]"
      assert_select "input[name=?]", "user[password]"
      assert_select "input[type=submit][value=?]", I18n.t("devise.sessions.sign_in")
    end
  end

  test "confirmed user can log in with valid credentials" do
    post user_session_path, params: {
      user: {
        email: @user.email,
        password: "password"
      }
    }

    follow_redirect!
    assert_response :success
    assert_select "h1", @user.email

    assert session["warden.user.user.key"].present?
  end

  test "user cannot log in with invalid credentials" do
    post user_session_path, params: {
      user: {
        email: @user.email,
        password: "wrongpassword"
      }
    }

    assert_response :unprocessable_entity
    assert_select "h3", I18n.t("devise.failure.not_found_in_database", authentication_keys: "Email")

    assert_nil session["warden.user.user.key"]
  end

  test "unconfirmed user is redirected to instructions after login attempt" do
    post user_session_path, params: {
      user: {
        email: @unconfirmed_user.email,
        password: "password"
      }
    }

    assert_response :redirect
    follow_redirect!
    assert_response :success
    assert_select "h2", I18n.t("instructions.title")

    assert_nil session["warden.user.user.key"]
  end

  test "sign-in page shows Google sign-in button" do
    assert_select "a[href=?]", user_google_oauth2_omniauth_authorize_path
  end

  test "sign-in page has link to sign-up page" do
    assert_select "p" do |elements|
      elements.each do |element|
        assert_match(/#{I18n.t('devise.sessions.create_account').strip}/, element.text.strip)
        assert_match(/#{I18n.t('devise.registrations.sign_up').strip}/, element.text.strip)
      end
    end

    assert_select "a[href=?]", new_user_registration_path
  end
end
