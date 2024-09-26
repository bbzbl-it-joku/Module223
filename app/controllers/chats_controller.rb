class ChatsController < ApplicationController
  before_action :require_login
  before_action :set_club
  before_action :authorize_club_member

  def index
    @chats = @club.chats.includes(:user).order(created_at: :desc).limit(100)
    @chat = Chat.new

    respond_to do |format|
      format.html
      format.js
    end
  end

  def create
    @chat = @club.chats.build(chat_params)
    @chat.user = current_user

    if @chat.save
      @chats = @club.chats.includes(:user).order(created_at: :desc).limit(100)
      respond_to do |format|
        format.html { redirect_to club_chats_path(@club), notice: "Message sent successfully." }
        format.js
      end
    else
      @chats = @club.chats.includes(:user).order(created_at: :desc).limit(100)
      render :index
    end
  end

  def destroy
    @chat = @club.chats.find(params[:id])
    if current_user == @chat.user || current_user.role == "ADMIN" || current_user == @club.created_by || @club.club_members.find_by(user_id: current_user.id).role == "ADMIN"
      @chat.destroy
      @chats = @club.chats.includes(:user).order(created_at: :desc).limit(100)
      respond_to do |format|
        format.html { redirect_to club_chats_path(@club), notice: "Message deleted successfully." }
        format.js
      end
    else
      redirect_to club_chats_path(@club), alert: "You are not authorized to delete this message."
    end
  end

  private

  def set_club
    @club = Club.find(params[:club_id])
  end

  def chat_params
    params.require(:chat).permit(:message)
  end

  def authorize_club_member
    unless @club.users.include?(current_user)
      redirect_to @club, alert: "You must be a member of this club to access the chat."
    end
  end
end
