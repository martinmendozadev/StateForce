require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [ 1400, 1400 ] do |options|
    options.add_argument("--no-sandbox")
    options.add_argument("--disable-dev-shm-usage")
    options.add_argument("--disable-gpu")
    options.add_argument("--disable-site-isolation-trials")
    options.add_argument("--headless=new")

    prefs = {
      "credentials_enable_service" => false,
      "profile.password_manager_enabled" => false
    }
    options.add_preference(:prefs, prefs)
  end
end
