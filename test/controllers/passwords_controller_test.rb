require "test_helper"

class PasswordsControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
  end

  test "should get edit" do
    sign_in_as(@user)
    get edit_password_url
    assert_response :success
  end

  test "should update password" do
    sign_in_as(@user)
    patch update_password_url, params: {
      current_password: "password123",
      user: {
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
    sign_in_as(@user)
    patch update_password_url, params: {
      current_password: "wrongpassword",
      user: {
        password: "newpassword123",
        password_confirmation: "newpassword123"
      }
    }
    assert_response :unprocessable_entity
    # Verify that the password was not changed
    @user.reload
    assert_not @user.authenticate("newpassword123")
  end

  test "should not update password with mismatched confirmation" do
    sign_in_as(@user)
    patch update_password_url, params: {
      current_password: "password123",
      user: {
        password: "newpassword123",
        password_confirmation: "differentpassword"
      }
    }
    assert_response :unprocessable_entity
    # Verify that the password was not changed
    @user.reload
    assert_not @user.authenticate("newpassword123")
  end

  private

  def sign_in_as(user)
    post login_url, params: { email: user.email, password: "password123" }
  end
end
