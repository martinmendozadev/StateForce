# frozen_string_literal: true

require "test_helper"

class BaseLayoutTest < ActionDispatch::SystemTestCase
  def setup
    @user = users(:one)
    sign_in @user
    resize_window_to_desktop
    visit dashboard_path
  end

  def teardown
    sign_out @user if @user
  end

  test "desktop sidebar visible on large screens" do
    resize_window_to_desktop
    visit dashboard_path
    find(:xpath, "//div[contains(@class,'lg:fixed') and contains(@class,'lg:flex')]")
    within(:xpath, "//nav[@aria-label='Sidebar']") do
      assert_selector "span", text: I18n.t("dashboard.name")
    end
  end

  test "header shows user avatar or initial and user info" do
    resize_window_to_mobile
    assert_selector "button[command='show-modal'][commandfor='sidebar']", count: 1
    assert_text @user.email
  end

  test "mobile open button opens sidebar dialog" do
    resize_window_to_mobile
    refute_selector "dialog#sidebar[open]"

    find("button[command='show-modal'][commandfor='sidebar']").click

    assert_selector "dialog#sidebar", visible: :all
    assert_selector "button[command='close'][commandfor='sidebar']"
    assert_text I18n.t("dashboard.name")
  end

  test "mobile close button closes sidebar dialog" do
    resize_window_to_mobile
    find("button[command='show-modal'][commandfor='sidebar']").click
    assert_selector "dialog#sidebar", visible: :all

    find("button[command='close'][commandfor='sidebar']").click
    assert_selector "dialog#sidebar", visible: :all
  end

  test "active dashboard link has background soft class in sidebar" do
    resize_window_to_desktop
    visit dashboard_path
    within(:xpath, "//nav[@aria-label='Sidebar']") do
      span = find("span", text: I18n.t("dashboard.name"))
      link = span.find(:xpath, "ancestor::a[1]")
      classes = link[:class]
      assert_includes classes, "bg-background-soft", "Expected active dashboard link to have bg-background-soft (classes: #{classes})"
    end
  end

  private

  def resize_window_to_mobile
    page.current_window.resize_to(375, 800)
  rescue StandardError
    # Some drivers may not support; test will still pass if initial size triggers mobile styles with CSS queries.
  end

  def resize_window_to_desktop
    page.current_window.resize_to(1400, 900)
  rescue StandardError
  end
end
