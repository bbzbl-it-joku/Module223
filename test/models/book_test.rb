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

  test "isbn should be unique" do
    duplicate_book = @book.dup
    @book.save
    assert_not duplicate_book.valid?
  end

  test "isbn format should be valid" do
    valid_isbns = %w[1234567890 1234567890123 123-4-56-789012-3]
    valid_isbns.each do |valid_isbn|
      @book.isbn = valid_isbn
      assert @book.valid?, "#{valid_isbn.inspect} should be valid"
    end

    invalid_isbns = %w[12345 1234567890a ABCDEFGHIJ]
    invalid_isbns.each do |invalid_isbn|
      @book.isbn = invalid_isbn
      assert_not @book.valid?, "#{invalid_isbn.inspect} should be invalid"
    end
  end

  test "publish date should be present" do
    @book.publish_date = nil
    assert_not @book.valid?
  end

  test "description should not be too long" do
    @book.description = "a" * 2001
    assert_not @book.valid?
  end
end
