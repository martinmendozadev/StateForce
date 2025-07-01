require "test_helper"
require "selenium-webdriver"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ] do |options|
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--disable-site-isolation-trials")
    options.add_argument("--disable-features=PasswordCheck,AutofillServerCommunication,AutofillKeyMetrics")
    options.add_argument("--disable-popup-blocking")
    options.add_argument("--disable-extensions")
    options.add_argument("--headless=new")
    options.add_argument("--incognito")

    prefs = {
      "credentials_enable_service" => false,
      "profile.password_manager_enabled" => false,
      "safebrowsing.enabled" => false
    }
    options.add_preference(:prefs, prefs)
  end
end
