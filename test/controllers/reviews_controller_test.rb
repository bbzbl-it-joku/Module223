require "test_helper"

class ReviewsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @review = reviews(:one)
    @book = books(:one)
    @user = users(:one)
  end

  test "should get index" do
    log_in_as(@user)
    get book_reviews_path(@book)
    assert_response :success
  end

  test "should show review" do
    log_in_as(@user)
    get book_review_path(@book, @review)
    assert_response :success
  end

  test "should get new" do
    log_in_as(@user)
    get new_book_review_path(@book)
    assert_response :success
  end

  test "should create review" do
    log_in_as(@user)
    assert_difference("Review.count") do
      post book_reviews_path(@book), params: { review: { rating: 4, review_text: "Great book!" } }
    end
    assert_redirected_to book_path(@book)
  end

  test "should not create review with invalid information" do
    log_in_as(@user)
    assert_no_difference("Review.count") do
      post book_reviews_path(@book), params: { review: { rating: 6, review_text: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_book_review_path(@book, @review)
    assert_response :success
  end

  test "should update review" do
    log_in_as(@user)
    patch book_review_path(@book, @review), params: { review: { rating: 5 } }
    assert_redirected_to book_review_path(@book, @review)
    @review.reload
    assert_equal 5, @review.rating
  end

  test "should destroy review" do
    log_in_as(@user)
    assert_difference("Review.count", -1) do
      delete book_review_path(@book, @review)
    end
    assert_redirected_to book_path(@book)
  end

  private

  def review_params
    { rating: 5, review_text: "Great book!" }
  end

  def review_invalid_params
    { rating: 6, review_text: "" }
  end

  def log_in_as(user)
    post login_path, params: { email: user.email, password: "password1234" }
  end
end
