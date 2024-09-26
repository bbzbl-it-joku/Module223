require "test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  test "should get index" do
    get admins_index_url
    assert_response :success
  end

  test "should get user_management" do
    get admins_user_management_url
    assert_response :success
  end

  test "should get activity" do
    get admins_activity_url
    assert_response :success
  end
end
