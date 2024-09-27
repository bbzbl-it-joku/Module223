require "test_helper"

class ReadingListBooksControllerTest < ActionDispatch::IntegrationTest
  def setup
    @club = clubs(:one)
    @book = books(:one)
    @user = users(:one)
    @reading_list_book = reading_list_books(:one)
  end

  test "should create reading_list_book" do
    log_in_as(@user)
    assert_difference("ReadingListBook.count") do
      post club_reading_list_books_path(@club), params: { reading_list_book: { book_id: @book.id, status: "to_read" } }
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

  test "should update reading_list_book" do
    log_in_as(@user)
    patch club_reading_list_book_path(@club, @reading_list_book), params: { reading_list_book: { status: "reading" } }
    assert_redirected_to @club
    @reading_list_book.reload
    assert_equal "reading", @reading_list_book.status
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
    post club_reading_list_books_path(@club), params: { reading_list_book: { book_id: @book.id, status: "to_read" } }
    assert_redirected_to @club
  end
end
