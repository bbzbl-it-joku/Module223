require "test_helper"

class ClubTest < ActiveSupport::TestCase
  def setup
    @user = users(:one)
    @club = Club.new(name: "Test Club", description: "A test club", created_by: @user)
  end

  test "should be valid" do
    assert @club.valid?
  end

  test "name should be present" do
    @club.name = "     "
    assert_not @club.valid?
  end

  test "description should be present" do
    @club.description = "     "
    assert_not @club.valid?
  end

  test "name should be unique" do
    duplicate_club = @club.dup
    @club.save
    assert_not duplicate_club.valid?
  end

  test "name should not be too long" do
    @club.name = "a" * 101
    assert_not @club.valid?
  end

  test "description should not be too long" do
    @club.description = "a" * 1001
    assert_not @club.valid?
  end

  test "created_by should be present" do
    @club.created_by = nil
    assert_not @club.valid?
  end
end
