require "test_helper"

class PlaysControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get plays_create_url
    assert_response :success
  end

  test "should get destroy" do
    get plays_destroy_url
    assert_response :success
  end
end
