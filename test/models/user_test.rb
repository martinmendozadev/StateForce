# frozen_string_literal: true

require "test_helper"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:user_one)
    @unconfirmed_user = users(:user_three)
  end

  test "user fixture is valid" do
    assert users(:user_two).valid?
  end

  test "user requires an email" do
    @user.email = nil
    assert_not @user.valid?
    assert_includes @user.errors[:email], "can't be blank"
  end

  test "user email must be unique" do
    duplicate_user = @user.dup
    duplicate_user.email = @user.email.downcase
    assert_not duplicate_user.valid?
    assert_includes duplicate_user.errors[:email], "has already been taken"
  end

  test "confirmed user is recognized as confirmed" do
    assert @user.confirmed?
  end

  test "unconfirmed user is not recognized as confirmed" do
    assert_not @unconfirmed_user.confirmed?
  end

  test "user has a valid encrypted password" do
    assert @user.encrypted_password.present?
  end

  test "user has a valid role" do
    assert_includes [ 0, 1, 2 ], @user.role # Need to be changed to enum
    # assert_includes User.roles.keys, @user.role
  end
end
