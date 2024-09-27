require "test_helper"

class SessionsControllerTest < ActionDispatch::IntegrationTest
  test "should get new" do
    get login_path
    assert_response :success
  end

  test "should create session" do
    user = users(:one)
    post login_path, params: { email: user.email, password: "password" }
    assert_redirected_to root_path
    assert is_logged_in?
  end

  test "should not create session with invalid information" do
    post login_path, params: { email: "", password: "" }
    assert_response :unprocessable_entity
    assert_not is_logged_in?
  end

  test "should destroy session" do
    log_in_as(users(:one))
    delete logout_path
    assert_redirected_to root_path
    assert_not is_logged_in?
  end
end
