require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_password_path
    assert_response :success
  end

  test "should not get edit when not logged in" do
    get edit_password_path
    assert_redirected_to login_path
  end

  test "should update password" do
    log_in_as(@user)
    patch update_password_path, params: {
                                  user: {
                                    current_password: "password1234",
                                    password: "newpassword123",
                                    password_confirmation: "newpassword123"
                                  }
                                }
    assert_redirected_to @user
    # Verify that the password was actually changed
    @user.reload
    assert @user.authenticate("newpassword123")
  end

  test "should not update password with incorrect current password" do
    log_in_as(@user)
    patch update_password_url, params: {
                                 user: {
                                   current_password: "wrongpassword",
                                   password: "newpassword1234",
                                   password_confirmation: "newpassword1234"
                                 }
                               }
    assert_response :unprocessable_entity
    # Verify that the password was not changed
    @user.reload
    assert_not @user.authenticate("newpassword123")
  end

  test "should not update password with mismatched confirmation" do
    log_in_as(@user)
    patch update_password_url, params: {
                                 user: {
                                   current_password: "password1234",
                                   password: "newpassword1234",
                                   password_confirmation: "differentpassword"
                                 }
                               }
    assert_response :unprocessable_entity
    # Verify that the password was not changed
    @user.reload
    assert_not @user.authenticate("newpassword123")
  end

  private

  def log_in_as(user)
    post login_path, params: { email: user.email, password: "password1234" }
  end
end
