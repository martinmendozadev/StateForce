require "test_helper"
require "faker"

class Users::OmniauthCallbacksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user =  {
      email: Faker::Internet.email
    }

    get new_user_session_path
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

  test "should set session data and redirect when user not persisted" do
    # Build a normal looking auth hash (valid credentials case) so controller reaches else via persisted? false
    auth_hash = OmniAuth::AuthHash.new(
      provider: "google_oauth2",
      uid: "unsaved-uid-123",
      info: OmniAuth::AuthHash::InfoHash.new(email: "unsaved_user@example.com", name: "Unsaved User")
    )

    # Unsaved user with an error to surface in flash alert
    failing_user = User.new(email: auth_hash.info.email, provider: "google_oauth2", uid: auth_hash.uid)
    failing_user.errors.add(:base, "Could not save user from omniauth")

    # Manually override the class method (since stub not available) and restore afterwards
    original_method = User.method(:from_omniauth)
    begin
      User.define_singleton_method(:from_omniauth) { |_auth| failing_user }
      OmniAuth.config.mock_auth[:google_oauth2] = auth_hash
      get user_google_oauth2_omniauth_callback_path
      assert_redirected_to new_user_registration_url

      stored = session["devise.google_data"]
      assert stored, "Expected devise.google_data to be stored in session"
      assert_equal auth_hash.provider, stored[:provider]
      assert_equal auth_hash.uid, stored[:uid]
      assert_equal auth_hash.info.email, stored.dig(:info, :email)

      assert_includes flash[:alert], "Could not save user from omniauth"
    ensure
      User.define_singleton_method(:from_omniauth, original_method)
    end
  end
end
