# rubocop:disable Metrics/LineLength
class ClubMembersController < ApplicationController
  before_action :require_login
  before_action :set_club
  before_action :set_club_member, only: [ :update, :destroy ]
  before_action :authorize_club_admin

  def create
    @club_member = @club.club_members.build(club_member_params)

    if @club_member.save
      redirect_to @club, notice: "Member was successfully added to the club."
    else
      redirect_to error_path, alert: "Failed to add member: #{@club_member.errors.full_messages.join(", ")}"
    end
  end

  def update
    if @club_member.update(club_member_params)
      redirect_to @club, notice: "Member role was successfully updated."
    else
      redirect_to error_path, alert: "Failed to update member role: #{@club_member.errors.full_messages.join(", ")}"
    end
  end

  def destroy
    @club_member.destroy
    redirect_to @club, notice: "Member was successfully removed from the club."
  end

  def invite
    @user = User.find_by(email: params[:email])

    if @user
      @club_member = @club.club_members.build(user: @user, role: "member")
      if @club_member.save
        # Send invitation email
        ClubMailer.invite(@club_member).deliver_later
        redirect_to @club, notice: "Invitation sent successfully."
      else
        redirect_to error_path, alert: "Failed to invite member: #{@club_member.errors.full_messages.join(", ")}"
      end
    else
      redirect_to error_path, alert: "User not found with the provided email."
    end
  end

  private

  def set_club
    @club = Club.find(params[:club_id])
  end

  def set_club_member
    @club_member = @club.club_members.find(params[:id])
  end

  def authorize_club_admin
    unless @club.club_members.exists?(user: current_user, role: "ADMIN") || current_user.role == "ADMIN"
      redirect_to error_path, alert: "You must be a club admin to perform this action."
    end
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end

  def club_member_params
    params.require(:club_member).permit(:user_id, :role)
  end
end

# rubocop:enable Metrics/LineLength
