# frozen_string_literal: true

require "test_helper"

class UserSignInTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_one)
    @unconfirmed_user = users(:user_three)

    get new_user_session_path
    assert_response :success
  end

  test "user can access the sign-in page" do
    assert_select "h2", I18n.t("devise.sessions.sign_in")
  end

  test "user can return to index page" do
    assert_select "a[href=?]", root_path
  end

  test "user can see the sign-in form elements" do
    assert_select "form[action=?][method=post]", user_session_path do
      assert_select "input[name=?]", "user[email]"
      assert_select "input[name=?]", "user[password]"
      assert_select "input[type=submit][value=?]", I18n.t("devise.sessions.sign_in")
    end
  end

  test "user email validated can log in with valid credentials" do
    post user_session_path, params: {
      user: {
        email: @user.email,
        password: "password"
      }
    }

    follow_redirect!
    assert_response :success
    assert_select "h1", @user.email
  end

  test "user cannot log in with invalid credentials" do
    post user_session_path, params: {
      user: {
        email: @user.email,
        password: Faker::String.random(length: 8)
      }
    }

    assert_response :unprocessable_entity
    assert_select "h3", I18n.t("devise.failure.not_found_in_database", authentication_keys: "Email")
  end

  test "user cannot log in with unconfirmed email" do
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
  end

  test "user can see google sign-in button" do
    assert_select "a[href=?]", user_google_oauth2_omniauth_authorize_path
  end

  test "user can access to sign-up page from sign-in page" do
    assert_select "p" do |elements|
      elements.each do |element|
        assert_match(/#{I18n.t('devise.sessions.create_account').strip}/, element.text.strip)
        assert_match(/#{I18n.t('devise.registrations.sign_up').strip}/, element.text.strip)
      end
    end

    assert_select "a[href=?]", new_user_registration_path
  end
end
