require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  test "should get instructions" do
    get users_instructions_url
    assert_response :success
  end
end
