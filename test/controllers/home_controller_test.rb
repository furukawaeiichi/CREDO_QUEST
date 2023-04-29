require "test_helper"

class HomeControllerTest < ActionDispatch::IntegrationTest
  test "should get top" do
    get home_top_url
    assert_response :success
  end

  test "should get special_thanks" do
    get home_special_thanks_url
    assert_response :success
  end
end
