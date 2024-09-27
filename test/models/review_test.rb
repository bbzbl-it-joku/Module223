require "test_helper"

class ReviewTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @book = books(:one)
    @review = Review.new(user: @user, book: @book, rating: 4, review_text: "A good book")
  end

  test "should be valid" do
    assert @review.valid?
  end

  test "user_id should be present" do
    @review.user_id = nil
    assert_not @review.valid?
  end

  test "book_id should be present" do
    @review.book_id = nil
    assert_not @review.valid?
  end

  test "rating should be present" do
    @review.rating = nil
    assert_not @review.valid?
  end

  test "rating should be within valid range" do
    invalid_ratings = [ -1, 0, 6 ]
    invalid_ratings.each do |invalid_rating|
      @review.rating = invalid_rating
      assert_not @review.valid?, "#{invalid_rating} should be invalid"
    end

    valid_ratings = [ 1, 2, 3, 4, 5 ]
    valid_ratings.each do |valid_rating|
      @review.rating = valid_rating
      assert @review.valid?, "#{valid_rating} should be valid"
    end
  end

  test "review_text should not be too long" do
    @review.review_text = "a" * 2001
    assert_not @review.valid?
  end
end
