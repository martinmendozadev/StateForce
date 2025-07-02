# frozen_string_literal: true

require "simplecov"
require "simplecov-cobertura"
SimpleCov.formatters = SimpleCov::Formatter::MultiFormatter.new([
  SimpleCov::Formatter::HTMLFormatter,
  SimpleCov::Formatter::CoberturaFormatter
])
SimpleCov.start "rails"

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"
require "omniauth"
require "faker"

OmniAuth.config.test_mode = true

module OmniAuthTestHelper
  def mock_google_auth(email: Faker::Internet.email,
    uid: Faker::Number.number(digits: 10),
    name: Faker::Name.name,
    image_url: Faker::Avatar.image
    )
    OmniAuth.config.mock_auth[:google_oauth2] = OmniAuth::AuthHash.new({
      provider: "google_oauth2",
      uid: uid,
      info: {
        email: email,
        name: name,
        image: image_url
      }
    })
  end
end

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    include Devise::Test::IntegrationHelpers
    include Warden::Test::Helpers
    include OmniAuthTestHelper

    def integration_test?
      self.is_a?(ActionDispatch::IntegrationTest)
    end

    def log_in(user)
      if integration_test?
        login_as(user, scope: :user)
      else
        sign_in user
      end
    end

    def log_out(user = nil)
      if integration_test?
        logout(user)
      elsif self.is_a?(ActionDispatch::SystemTestCase)
        logout(user)
        Warden.test_reset!
      else
        sign_out(user)
      end
    end
  end
end
