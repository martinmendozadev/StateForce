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
end
