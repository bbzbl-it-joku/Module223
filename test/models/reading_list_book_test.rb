require "test_helper"

class ReadingListBookTest < ActiveSupport::TestCase
  def setup
    @club = clubs(:one)
    @book = books(:one)
    @reading_list_book = ReadingListBook.new(club: @club, book: @book, status: "to_read", added_at: Time.current)
  end

  test "club_id should be present" do
    @reading_list_book.club_id = nil
    assert_not @reading_list_book.valid?
  end

  test "book_id should be present" do
    @reading_list_book.book_id = nil
    assert_not @reading_list_book.valid?
  end

  test "book should be unique within a club's reading list" do
    duplicate_reading_list_book = @reading_list_book.dup
    @reading_list_book.save
    assert_not duplicate_reading_list_book.valid?
  end

  test "added_at should be present" do
    @reading_list_book.added_at = nil
    assert_not @reading_list_book.valid?
  end
end
