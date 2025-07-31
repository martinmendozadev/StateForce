require "test_helper"
require "faker"

class UserPolicyTest < ActiveSupport::TestCase
  #
  # def setup
  #  @admin = users(:admin)
  #  @standard  = users(:standard)
  #  @guest = users(:guest)
  # end

  #  %i[index show update destroy].each do |action|
  #   define_method("test_admin_can_#{action}") do
  #     policy = UserPolicy.new(@admin, @standard)
  #     assert policy.public_send("#{action}?"), "Admin should be able to #{action} any user"
  #   end
  # end

  #  %i[show update].each do |action|
  #   define_method("test_user_can_#{action}_self") do
  #    policy = UserPolicy.new(@standard, @standard)
  #   assert policy.public_send("#{action}?"), "User should be able to #{action} self"
  # end

  #    define_method("test_user_cannot_#{action}_other") do
  #     policy = UserPolicy.new(@standard, @guest)
  #    refute policy.public_send("#{action}?"), "User should not be able to #{action} another user"
  # end
  # end

  #  %i[index destroy].each do |action|
  #   define_method("test_user_cannot_#{action}") do
  #    policy = UserPolicy.new(@standard, @guest)
  #   refute policy.public_send("#{action}?"), "User should not be able to #{action} other users"
  # end
  # end
end
