require "test_helper"

class ReadingListBooksControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get reading_list_books_create_url
    assert_response :success
  end

  test "should get destroy" do
    get reading_list_books_destroy_url
    assert_response :success
  end

  test "should get update" do
    get reading_list_books_update_url
    assert_response :success
  end
end
