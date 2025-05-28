# frozen_string_literal: true

require "test_helper"
require "faker"

class LandingTest < ActionDispatch::SystemTestCase
  def setup
    visit root_path
  end

  test "landing page renders main elements" do
    assert_selector "img.h-16"

    assert_text I18n.t("landing.hero.title")
    assert_text I18n.t("landing.hero.subtitle")

    assert_selector "a[href='#{new_user_registration_path}']", text: I18n.t("landing.hero.cta.primary")
    assert_selector "a[href='#{new_user_session_path}']", text: I18n.t("landing.nav.login")
    assert_selector "a[href='#{learn_more_path}']", text: I18n.t("landing.nav.learn_more")
  end
end
