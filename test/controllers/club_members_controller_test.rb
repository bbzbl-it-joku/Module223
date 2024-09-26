require "test_helper"

class ClubMembersControllerTest < ActionDispatch::IntegrationTest
  test "should get create" do
    get club_members_create_url
    assert_response :success
  end

  test "should get update" do
    get club_members_update_url
    assert_response :success
  end

  test "should get destroy" do
    get club_members_destroy_url
    assert_response :success
  end

  test "should get invite" do
    get club_members_invite_url
    assert_response :success
  end
end
