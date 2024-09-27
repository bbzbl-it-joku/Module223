require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  def setup
    @user = users(:one)
    @admin = users(:admin)
    @other_user = users(:two)
  end

  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should create user" do
    assert_difference("User.count") do
      post users_path, params: { user: { username: "newuser", email: "newuser@example.com", password: "password123456", password_confirmation: "password123456" } }
    end
    assert_redirected_to root_path
  end

  test "should show user" do
    log_in_as(@user)
    get user_path(@user)
    assert_response :success
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_response :success
  end

  test "should update user" do
    log_in_as(@user)
    patch user_path(@user), params: { user: { username: "updatedname" } }
    assert_redirected_to @user
    @user.reload
    assert_equal "updatedname", @user.username
  end

  test "should not update user with invalid email" do
    log_in_as(@user)
    patch user_path(@user), params: { user: { email: "invalid" } }
    assert_response :unprocessable_entity
  end

  test "should destroy user" do
    log_in_as(@admin)
    assert_difference("User.count", -1) do
      delete user_path(@other_user)
    end
    assert_redirected_to root_path
  end

  test "should not allow user to edit another user's profile" do
    log_in_as(@user)
    get edit_user_path(@other_user)
    assert_redirected_to root_path
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_path
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to login_path
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference "User.count" do
      delete user_path(@user)
    end
    assert_redirected_to root_path
  end
end
