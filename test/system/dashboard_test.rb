# frozen_string_literal: true

require "test_helper"

class DashboardTest < ActionDispatch::SystemTestCase
  def setup
    @user = users(:one)

    log_out @user
    log_in @user
  end

  def teardown
    log_out @user
  end
end
