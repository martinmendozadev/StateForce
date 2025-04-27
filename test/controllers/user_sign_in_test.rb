# frozen_string_literal: true

require "test_helper"

class UserSignInTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:user_one)
    @unconfirmed_user = users(:user_three)
  end

  test "user can log in with valid credentials" do
    get new_user_session_path
    assert_response :success

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
    get new_user_session_path
    assert_response :success

    post user_session_path, params: {
      user: {
        email: @user.email,
        password: Faker::String.random(length: 9)
      }
    }

    assert_response :unprocessable_entity
    assert_select "h3", I18n.t("devise.failure.not_found_in_database", authentication_keys: "Email")
  end

  test "user cannot log in with unconfirmed email" do
    get new_user_session_path
    assert_response :success

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
end
