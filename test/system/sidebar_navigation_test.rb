# frozen_string_literal: true

require "test_helper"

class SidebarNavigationTest < ActionDispatch::SystemTestCase
  MENU_TRANSLATIONS = [
    "dashboard.name",
    "event.name",
    "resource.name",
    "institution.name",
    "calendar.name",
    "audit_log.name",
    "settings.name"
  ].freeze

  def setup
    @user = users(:one)
    sign_in @user
  end

  def teardown
    sign_out @user if @user
  end

  test "desktop sidebar lists all main menu items" do
    resize_window_to_desktop
    visit dashboard_path

    within_desktop_sidebar do
      found = 0
      MENU_TRANSLATIONS.each do |key|
        next unless translation_present?(key)
        unless has_selector?("span", text: I18n.t(key))
          flunk "Missing menu item: #{key} => #{I18n.t(key)}"
        end
        found += 1
      end
      assert found > 0, "Expected to find at least one menu item"
      assert_equal MENU_TRANSLATIONS.count { |k| translation_present?(k) }, found, "Mismatch in expected vs found menu items"
    end
  end

  test "mobile sidebar dialog lists all main menu items after open" do
    resize_window_to_mobile
    visit dashboard_path

    find("button[command='show-modal'][commandfor='sidebar']").click
    assert_selector "dialog#sidebar", visible: :all

    within_mobile_sidebar do
      MENU_TRANSLATIONS.each do |key|
        next unless translation_present?(key)
        unless has_selector?("span", text: I18n.t(key))
          flunk "Missing menu item (mobile): #{key} => #{I18n.t(key)}"
        end
      end
    end
  end

  private

  def within_desktop_sidebar(&block)
    within(:xpath, "//div[contains(@class,'lg:fixed') and contains(@class,'lg:flex')]//nav[@aria-label='Sidebar']", &block)
  end

  def within_mobile_sidebar(&block)
    within(:xpath, "//dialog[@id='sidebar']//nav[@aria-label='Sidebar']", &block)
  end

  def translation_present?(key)
    I18n.exists?(key)
  end

  def resize_window_to_mobile
    page.current_window.resize_to(400, 800)
  rescue StandardError
  end

  def resize_window_to_desktop
    page.current_window.resize_to(1400, 900)
  rescue StandardError
  end
end
