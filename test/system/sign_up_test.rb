# frozen_string_literal: true

require "test_helper"
require "faker"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  def setup
    @user_password = Faker::Internet.password(min_length: 8)
    @user_email = Faker::Internet.email
  end

  test "user can sign up with email and password successfully" do
    visit new_user_registration_path

    fill_in I18n.t("devise.registrations.email"), with: @user_email
    fill_in I18n.t("devise.registrations.password"), with: @user_password
    fill_in I18n.t("devise.registrations.password_confirmation"), with: @user_password
    click_on I18n.t("devise.registrations.sign_up_button")

    assert_current_path users_instructions_path
  end
  test "user cannot sign up with mismatched passwords" do
    visit new_user_registration_path

    fill_in I18n.t("devise.registrations.email"),  with: @user_email
    fill_in I18n.t("devise.registrations.password"), with: @user_password
    fill_in I18n.t("devise.registrations.password_confirmation"), with: "mismatched_password"
    click_on I18n.t("devise.registrations.sign_up_button")

    assert_text I18n.t("activerecord.errors.models.user.attributes.password_confirmation.confirmation")
    # assert_text "Password confirmation doesn't match Password"
  end
end
