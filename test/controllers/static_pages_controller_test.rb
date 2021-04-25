require 'test_helper'

class StaticPagesControllerTest < ActionDispatch::IntegrationTest



  test "should get help" do
    get help_path
    assert_response :success
    assert_select "title", "blackjack"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "blackjack"
  end

end