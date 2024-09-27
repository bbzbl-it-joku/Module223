require "test_helper"

class BooksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @book = books(:one)
    @user = users(:one)
  end

  test "should get index" do
    get books_path
    assert_response :success
  end

  test "should show book" do
    get book_path(@book)
    assert_response :success
  end

  private

  def logged_in?
    !!session[:user_id]
  end

  def log_in_as(user)
    post login_path, params: { email: user.email, password: "password" }
  end
end
