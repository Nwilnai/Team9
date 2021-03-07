require "test_helper"

class UserPagesControllerTest < ActionDispatch::IntegrationTest
  test "should get login" do
    get user_pages_login_url
    assert_response :success
  end
end
