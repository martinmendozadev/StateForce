require "test_helper"
require "faker"

class Users::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user =  {
      email: Faker::Internet.email
    }

    get new_user_session_path
    assert_response :success
  end

  def teardown
    log_out(@user)
  end

  test "should sign in user with valid Google data" do
    mock_google_auth(email: @user[:email])
    get user_google_oauth2_omniauth_callback_path
    follow_redirect!
    assert_equal dashboard_path, path
    assert_match @user[:email], @response.body
  end

  test "should redirect to sign up on failure" do
    OmniAuth.config.mock_auth[:google_oauth2] = :invalid_credentials
    get user_google_oauth2_omniauth_callback_path
    follow_redirect!
    assert_equal new_user_session_path, path

    expected_message = I18n.t("devise.omniauth_callbacks.failure", kind: "GoogleOauth2", reason: "Invalid credentials")
    require "cgi"
    assert_match CGI.escapeHTML(expected_message), @response.body
  end
end
