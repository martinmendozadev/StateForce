require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    get user_session_path
    @user = users(:user_one)
    sign_in @user
    # post user_session_path
  end

  test "should get index" do
    get dashboard_url
    assert_response :success
  end

  test "should not be able to access dashboard without login" do
    sign_out @user
    get dashboard_url
    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_response :success
    assert_select "h2", "Sign in"
  end

  test "should not be accessible to non-verified email users" do
    sign_out @user

    @unconfirmed_user = users(:user_three)
    sign_in @unconfirmed_user

    get dashboard_url

    assert_redirected_to users_instructions_path
    follow_redirect!

    assert_response :success
    assert_select "h2", I18n.t("instructions.title")
  end
end
