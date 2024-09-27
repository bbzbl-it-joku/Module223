require "test_helper"

class ClubMemberTest < ActiveSupport::TestCase
  def setup
    @club = clubs(:one)
    @user = users(:one)
    @club_member = ClubMember.new(club: @club, user: @user, role: "MEMBER")
  end

  test "should be valid" do
    assert @club_member.valid?
  end

  test "club_id should be present" do
    @club_member.club_id = nil
    assert_not @club_member.valid?
  end

  test "user_id should be present" do
    @club_member.user_id = nil
    assert_not @club_member.valid?
  end

  test "user should be unique within a club" do
    duplicate_member = @club_member.dup
    @club_member.save
    assert_not duplicate_member.valid?
  end
end
