require "test_helper"

class DashboardsControllerTest < ActionDispatch::IntegrationTest
  include Devise::Test::IntegrationHelpers

  def setup
    @user = users(:one)
    sign_in @user
  end

  def teardown
    log_out @user
  end

  test "should get dashboard index for confirmed and signed in users" do
    get dashboard_path
    assert_response :success
  end

  test "should redirect to login if not signed in" do
    sign_out @user

    get dashboard_path

    assert_redirected_to new_user_session_path
    follow_redirect!
    assert_response :success
  end

  test "should redirect to instructions if signed in but not confirmed emails" do
    sign_out @user

    @unconfirmed_user = users(:user_three)
    sign_in @unconfirmed_user

    get dashboard_path

    assert_redirected_to users_instructions_path
    follow_redirect!
    assert_response :success
  end
end
