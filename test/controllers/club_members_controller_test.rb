require "test_helper"

class ClubMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = users(:one)
    @user2 = users(:two)
    @admin = users(:admin)
    @club = clubs(:one)
    @club2 = clubs(:two)
    @club_member_one = club_members(:one)
    @club_member_one_member = club_members(:one_member)
    @club_member_two = club_members(:two)
  end

  test "should create club_member" do
    log_in_as(@user)
    assert_difference("ClubMember.count") do
      post join_club_path(@club2)
    end
    assert_redirected_to @club2
  end

  test "should destroy club_member" do
    log_in_as(@admin)
    assert_difference("ClubMember.count", -1) do
      delete club_club_member_url(@club, @club_member_one_member)
    end
    assert_redirected_to @club
  end

  private

  def log_in_as(user)
    post login_path, params: { email: user.email, password: "password1234" }
  end
end
