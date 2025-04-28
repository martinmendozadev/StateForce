# frozen_string_literal: true

require "test_helper"

class UserSignupTest < ActionDispatch::IntegrationTest
  def setup
    @user = {
      last_name: Faker::Name.last_name,
      first_name: Faker::Name.first_name,
      email: Faker::Internet.email,
      password: "password123",
      password_confirmation: "password123"
    }

    get new_user_registration_path
    assert_response :success
  end

  test "user can access the sign-up page" do
    assert_select "h2", I18n.t("devise.registrations.sign_up")
  end

  test "user can return to index page" do
    assert_select "a[href=?]", root_path
  end

  test "user can see the sign-up form elements" do
    get new_user_registration_path
    assert_response :success

    assert_select "form[action=?][method=post]", user_registration_path do
      assert_select "input[name=?]", "user[email]"
      assert_select "input[name=?]", "user[password]"
      assert_select "input[name=?]", "user[password_confirmation]"
      assert_select "input[type=submit][value=?]", I18n.t("devise.registrations.sign_up_button")
    end
  end

   test "user can sign up with valid information" do
    assert_difference "User.count", 1 do
      post user_registration_path, params: { user: @user }
    end

    follow_redirect!
    assert_response :success
    assert_select "h2", I18n.t("instructions.title")

    created_user = User.find_by(email: @user[:email])

    assert_not_nil created_user, "User was not stored in the database"

    assert_equal @user[:email], created_user.email

    assert created_user.valid_password?(@user[:password]), "Password was not stored correctly"
  end

  test "user cannot sign up if passwords doesn't match" do
    assert_no_difference "User.count" do
      post user_registration_path, params: {
        user: {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: "password123",
          password_confirmation: "123password"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "div", "Password confirmation doesn't match Password"
  end

  test "user cannot sign up with email registred before" do
    assert_no_difference "User.count" do
      post user_registration_path, params: {
        user: {
          email: users(:user_one).email,
          password: "password123",
          password_confirmation: "password123"
        }
      }
    end

    assert_response :unprocessable_entity
    assert_select "div.text-red-500", /#{I18n.t('errors.messages.taken')}/
  end

  test "user can see google sign-up button" do
    assert_select "a[href=?]", user_google_oauth2_omniauth_authorize_path
  end

  test "user can access to sign-in page from sign-up page" do
    assert_select "p" do |elements|
      elements.each do |element|
        assert_match(/#{I18n.t('devise.registrations.already_have_account').strip}/, element.text.strip)
        assert_match(/#{I18n.t('devise.registrations.sign_in').strip}/, element.text.strip)
      end
    end

    assert_select "a[href=?]", new_user_session_path
  end
end
