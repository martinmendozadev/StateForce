# frozen_string_literal: true

require "test_helper"

class UserSignInTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @unconfirmed_user = users(:user_three)

    get new_user_session_path
  end

  def teardown
    log_out(@user)
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
    assert_equal dashboard_path, path

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
    assert_equal new_user_session_path, path

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
    assert_equal users_instructions_path, path

    assert_nil session["warden.user.user.key"]
  end
end
