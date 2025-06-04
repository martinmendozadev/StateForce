# frozen_string_literal: true

require "test_helper"

class DashboardTest < ActionDispatch::SystemTestCase
  def setup
    @user = users(:user_one)
    sign_in @user
  end

  def teardown
    page.execute_script(%Q{
      fetch("#{destroy_user_session_path}", {method: "DELETE", credentials: "same-origin"});
    })
  end

  test "dashboard shows user email and logout button" do
    visit dashboard_path

    assert_text @user.email

    assert_selector "form[action='#{destroy_user_session_path}'] button", text: I18n.t("devise.sessions.logout")
  end
end
