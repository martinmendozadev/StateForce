# frozen_string_literal: true

require "test_helper"
require "ostruct"

class UserTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @unconfirmed_user = users(:user_three)
  end

  test "user fixture is valid" do
    assert @user.valid?
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

  test "email format validation rejects invalid emails" do
    @user.email = "not-an-email"
    assert_not @user.valid?
    assert_includes @user.errors[:email], "is invalid"
  end

  test "email length validation enforces maximum" do
    long_local = "a" * 140
    # make overall length > 150
    @user.email = "#{long_local}@example.com"
    assert @user.email.length > 150
    assert_not @user.valid?
    assert_includes @user.errors[:email], "is too long (maximum is 150 characters)"
  end

  test "name maximum length enforced" do
    @user.name = "x" * 76
    assert_not @user.valid?
    assert_includes @user.errors[:name], "is too long (maximum is 75 characters)"
  end

  test "uid is required when provider is present" do
    user = User.new(email: "omniauth@example.com", provider: "google_oauth2")
    user.uid = nil
    assert_not user.valid?
    assert_includes user.errors[:uid], "can't be blank"
  end

  test "password is required for new normal users but not for omniauth users" do
    normal = User.new(email: "normal@example.com")
    # new_record? true so password required
    assert_not normal.valid?
    assert_includes normal.errors[:password], "can't be blank"

    oauth = User.new(email: "oauth@example.com", provider: "google_oauth2", uid: "98765")
    # omniauth user with provider+uid should not require password
    oauth.password = nil
    assert oauth.valid?
  end

  test "password_required? reflects provider/uid presence" do
    oauth = users(:two) # fixture 'two' is an omniauth user
  assert_not oauth.password_required?
  # persisted fixture with encrypted_password should not require a password
  assert_not @user.password_required?
  end

  test "active_for_authentication? and inactive_message behavior" do
    # confirmed user
    assert @user.confirmed?
    assert @user.active_for_authentication?
    assert_not_equal :unconfirmed, @user.inactive_message

    # unconfirmed user
    refute @unconfirmed_user.confirmed?
    # According to implementation, unconfirmed users are considered active (super || !confirmed?)
    assert @unconfirmed_user.active_for_authentication?
    # but inactive_message should return :unconfirmed when asked
    assert_equal :unconfirmed, @unconfirmed_user.inactive_message
  end

  test "from_omniauth creates or finds user and sets fields" do
    auth = OpenStruct.new(
      provider: "google_oauth2",
      uid: "auth-uid-123",
      info: OpenStruct.new(email: "new-omniauth@example.com", name: "Omni User")
    )

    user = User.from_omniauth(auth)
    assert user.persisted?
    assert_equal "new-omniauth@example.com", user.email
    assert_equal "google_oauth2", user.provider
    assert_equal "auth-uid-123", user.uid
    assert user.confirmed_at.present?
  end

  test "from_omniauth finds existing user by email instead of creating duplicate" do
    existing = users(:one)
    auth = OpenStruct.new(
      provider: "google_oauth2",
      uid: "some-uid-xyz",
      info: OpenStruct.new(email: existing.email, name: "Existing")
    )

    found = User.from_omniauth(auth)
    assert_equal existing.id, found.id
  end

  test "valid email formats are accepted" do
    @user.email = "valid.email+tag@example.co"
    assert @user.valid?
  end

  test "provider enum mapping and avatar association" do
    google = users(:two)
    assert_equal "google_oauth2", google.provider
    # users(:one) has avatar: one in fixtures
    assert @user.avatar.present?
  end
end
