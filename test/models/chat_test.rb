require "test_helper"

class ChatTest < ActiveSupport::TestCase
  def setup
    @club = clubs(:one)
    @user = users(:one)
    @chat = Chat.new(club: @club, user: @user, message: "Hello, club!")
  end

  test "should be valid" do
    assert @chat.valid?
  end

  test "club_id should be present" do
    @chat.club_id = nil
    assert_not @chat.valid?
  end

  test "user_id should be present" do
    @chat.user_id = nil
    assert_not @chat.valid?
  end

  test "message should be present" do
    @chat.message = "     "
    assert_not @chat.valid?
  end

  test "message should not be too long" do
    @chat.message = "a" * 1001
    assert_not @chat.valid?
  end
end
