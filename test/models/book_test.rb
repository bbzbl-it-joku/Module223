require "test_helper"

class BookTest < ActiveSupport::TestCase
  def setup
    @book = Book.new(title: "Test Book", author: "Test Author", isbn: "1234567890", publish_date: Date.today, description: "A test book description")
  end

  test "should be valid" do
    assert @book.valid?
  end

  test "title should be present" do
    @book.title = "     "
    assert_not @book.valid?
  end

  test "author should be present" do
    @book.author = "     "
    assert_not @book.valid?
  end

  test "publish date should be present" do
    @book.publish_date = nil
    assert_not @book.valid?
  end

  test "description should not be too long" do
    @book.description = "a" * 5001
    assert_not @book.valid?
  end
end
