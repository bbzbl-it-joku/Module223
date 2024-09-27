require "test_helper"

class ReadingListBooksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @club = clubs(:one)
    @club2 = clubs(:two)
    @book = books(:one)
    @book2 = books(:two)
    @user = users(:one)
    @user_one_member = users(:two)
    @admin = users(:admin)
    @reading_list_book = reading_list_books(:one)
  end

  test "should create reading_list_book" do
    log_in_as(@user_one_member)
    assert_difference("ReadingListBook.count") do
      post club_reading_list_books_path(@club), params: { reading_list_book: { book_id: @book2.id } }

      if ReadingListBook.last.errors.any?
        puts ReadingListBook.last.errors.full_messages
      end
    end
    assert_redirected_to @club
  end

  test "should not create duplicate reading_list_book" do
    log_in_as(@user)
    assert_no_difference("ReadingListBook.count") do
      post club_reading_list_books_path(@club), params: { reading_list_book: { book_id: @reading_list_book.book_id, status: "to_read" } }
    end
    assert_redirected_to error_path
  end

  test "should destroy reading_list_book" do
    log_in_as(@user)
    assert_difference("ReadingListBook.count", -1) do
      delete club_reading_list_book_path(@club, @reading_list_book)
    end
    assert_redirected_to @club
  end

  test "should not allow non-members to modify reading list" do
    log_in_as(users(:two))
    assert_no_difference("ReadingListBook.count") do
      post club_reading_list_books_path(@club), params: { reading_list_book: { book_id: @book.id, status: "to_read" } }
    end
    assert_redirected_to error_path
  end

  private

  def log_in_as(user)
    post login_path, params: { email: user.email, password: "password1234" }
  end
end
