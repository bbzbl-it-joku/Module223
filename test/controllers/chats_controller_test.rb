require "test_helper"

class ChatsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @club = clubs(:one)
    @user = users(:one)
    @chat = chats(:one)
  end

  test "should get index" do
    log_in_as(@user)
    get club_chats_path(@club)
    assert_response :success
  end

  test "should create chat" do
    log_in_as(@user)
    assert_difference("Chat.count") do
      post club_chats_path(@club), params: { chat: { message: "Hello, club!" } }
    end
    assert_redirected_to club_chats_path(@club)
  end

  test "should not create chat with invalid information" do
    log_in_as(@user)
    assert_no_difference("Chat.count") do
      post club_chats_path(@club), params: { chat: { message: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should destroy chat" do
    log_in_as(@user)
    assert_difference("Chat.count", -1) do
      delete club_chat_path(@club, @chat)
    end
    assert_redirected_to club_chats_path(@club)
  end

  test "should not allow non-members to access chat" do
    log_in_as(users(:two))
    get club_chats_path(@club)
    assert_redirected_to @club
  end

  private

  def log_in_as(user)
    post login_path, params: { email: user.email, password: "password1234" }
  end
end
