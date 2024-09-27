require "test_helper"

class ClubsControllerTest < ActionDispatch::IntegrationTest
  def setup
    @club = clubs(:one)
    @user = users(:one)
    @other_user = users(:two)
  end

  test "should get index" do
    get clubs_path
    assert_response :success
  end

  test "should show club when logged in" do
    log_in_as(@user)
    get club_path(@club)
    assert_response :success
  end

  test "should not show club when not logged in" do
    get club_path(@club)
    assert_redirected_to login_path
  end

  test "should get new" do
    log_in_as(@user)
    get new_club_path
    assert_response :success
  end

  test "should create club" do
    log_in_as(@user)
    assert_difference("Club.count") do
      post clubs_path, params: { club: { name: "New Club", description: "A new book club" } }
    end
    assert_redirected_to club_path(Club.last)
  end

  test "should not create club with invalid information" do
    log_in_as(@user)
    assert_no_difference("Club.count") do
      post clubs_path, params: { club: { name: "", description: "" } }
    end
    assert_response :unprocessable_entity
  end

  test "should get edit" do
    log_in_as(@user)
    get edit_club_path(@club)
    assert_response :success
  end

  test "should update club" do
    log_in_as(@user)
    patch club_path(@club), params: { club: { name: "Updated Club Name" } }
    assert_redirected_to @club
    @club.reload
    assert_equal "Updated Club Name", @club.name
  end

  test "should destroy club" do
    log_in_as(@user)
    assert_difference("Club.count", -1) do
      delete club_path(@club)
    end
    assert_redirected_to clubs_path
  end

  test "should leave club" do
    log_in_as(@other_user)
    assert_difference("ClubMember.count", -1) do
      delete leave_club_path(@club)
    end
    assert_redirected_to @club
  end

  private

  def log_in_as(user)
    post login_path, params: { email: user.email, password: "password1234" }
  end
end
