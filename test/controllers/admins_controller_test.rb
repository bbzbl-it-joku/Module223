require "test_helper"

class AdminsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @admin = users(:admin)
    @user = users(:one)
  end

  test "should get index" do
    log_in_as(@admin)
    get admins_path
    assert_response :success
  end

  test "should get user management" do
    log_in_as(@admin)
    get users_admins_path
    assert_response :success
  end

  test "should get activity log" do
    log_in_as(@admin)
    get activity_admins_path
    assert_response :success
  end

  test "should redirect when non-admin tries to access admin pages" do
    log_in_as(@user)
    get admins_path
    assert_redirected_to root_path
    get users_admins_path
    assert_redirected_to root_path
    get activity_admins_path
    assert_redirected_to root_path
  end

  test "should redirect when not logged in" do
    get admins_path
    assert_redirected_to root_path
    get users_admins_path
    assert_redirected_to root_path
    get activity_admins_path
    assert_redirected_to root_path
  end

  private

  def log_in_as(user)
    post login_path, params: { email: user.email, password: "password" }
  end
end
