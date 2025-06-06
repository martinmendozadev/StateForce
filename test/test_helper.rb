# frozen_string_literal: true

ENV["RAILS_ENV"] ||= "test"
require_relative "../config/environment"
require "rails/test_help"

module ActiveSupport
  class TestCase
    # Run tests in parallel with specified workers
    parallelize(workers: :number_of_processors)

    # Setup all fixtures in test/fixtures/*.yml for all tests in alphabetical order.
    fixtures :all

    include Devise::Test::IntegrationHelpers
    include Warden::Test::Helpers

    def log_in(user)
      if integration_test?
          login_as(user, scope: :user)
      else
        sign_in(user)
      end
    end

    def log_out(user)
      if integration_test?
        logout(:user)
      else
        sign_out(user)
      end
    end
  end
end
