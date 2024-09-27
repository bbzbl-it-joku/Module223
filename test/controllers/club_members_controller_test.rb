require "test_helper"

class ClubMembersControllerTest < ActionDispatch::IntegrationTest
  setup do
    @user = create(:user)
    @admin = create(:user, :admin)
    @club = create(:club, created_by: @admin)
  end

  test "should create club_member" do
    sign_in_as(@admin)
    assert_difference("ClubMember.count") do
      post club_club_members_url(@club), params: { club_member: { user_id: @user.id, role: "MEMBER" } }
    end
    assert_redirected_to @club
  end

  test "should update club_member" do
    sign_in_as(@admin)
    club_member = create(:club_member, club: @club, user: @user)
    patch club_club_member_url(@club, club_member), params: { club_member: { role: "ADMIN" } }
    assert_redirected_to @club
    club_member.reload
    assert_equal "ADMIN", club_member.role
  end

  test "should destroy club_member" do
    sign_in_as(@admin)
    club_member = create(:club_member, club: @club, user: @user)
    assert_difference("ClubMember.count", -1) do
      delete club_club_member_url(@club, club_member)
    end
    assert_redirected_to @club
  end

  test "should not allow non-admin to create club_member" do
    sign_in_as(@user)
    assert_no_difference("ClubMember.count") do
      post club_club_members_url(@club), params: { club_member: { user_id: @user.id, role: "MEMBER" } }
    end
    assert_redirected_to @club
  end

  private

  def sign_in_as(user)
    post login_url, params: { email: user.email, password: "password123" }
  end
end
