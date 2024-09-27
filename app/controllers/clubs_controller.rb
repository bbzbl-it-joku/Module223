class ClubsController < ApplicationController
  before_action :require_login, except: [ :index ]
  before_action :set_club, only: [ :show, :edit, :update, :destroy, :join, :leave, :edit_members ]
  before_action :require_admin, only: [ :edit, :update, :destroy, :edit_members ]
  before_action :authorize_club, only: [ :edit, :update, :destroy, :edit_members ]

  def index
    @clubs = Club.all
  end

  def show
    @members = @club.club_members.includes(:user)
    @current_book = @club.current_book
    @reading_list = @club.reading_list_books.includes(:book)
  end

  def new
    @club = Club.new
  end

  def create
    @club = current_user.created_clubs.build(club_params)

    if @club.save
      if club_params[:current_book_id]
        @club.reading_list_books.create(book_id: club_params[:current_book_id], added_at: Time.now, status: "reading")
      end
      @club.club_members.create(user: current_user, role: "ADMIN")
      redirect_to @club, notice: "Club was successfully created."
    else
      redirect_to error_path, alert: "Failed to create club.", status: :unprocessable_entity
    end
  end

  def edit
  end

  def edit_members
    @club_members = @club.club_members.includes(:user)
  end

  def update
    if @club.update(club_params)
      update_reading_list_books
      redirect_to @club, notice: "Club was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    @club.destroy
    redirect_to clubs_url, notice: "Club was successfully deleted."
  end

  def join
    unless @club.users.include?(current_user)
      if @club.club_members.count == 0 || @club.created_by == current_user
        @club.club_members.create(user: current_user, role: "ADMIN")
      else
        @club.club_members.create(user: current_user, role: "MEMBER")
      end
      redirect_to @club, notice: "You have successfully joined the club."
    else
      redirect_to error_path, alert: "You are already a member of this club."
    end
  end

  def leave
    membership = @club.club_members.find_by(user: current_user)
    if membership && membership.role != "admin"
      membership.destroy
      redirect_to @club, notice: "You have left the club."
    else
      redirect_to error_path, alert: "You cannot leave this club."
    end
  end

  private

  def set_club
    @club = Club.find(params[:id])
  end

  def club_params
    params.require(:club).permit(:name, :description, :current_book_id)
  end

  def authorize_club
    unless @club.users.include?(current_user) && @club.club_members.find_by(user: current_user).role == "ADMIN" || current_user.role == "ADMIN"
      redirect_to error_path, alert: "You are not authorized to perform this action."
    end
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end

  def require_admin
    unless @club.users.include?(current_user) && @club.club_members.find_by(user: current_user).role == "ADMIN" || current_user.role == "ADMIN"
      redirect_to error_path, alert: "You are not authorized to perform this action."
    end
  end

  def update_reading_list_books
    @reading_list = @club.reading_list_books.includes(:book)
    @reading_list.each do |reading_list_book|
      if club_params[:current_book_id].to_i == reading_list_book.book_id
        reading_list_book.update(status: "reading")
      end
      if reading_list_book.status == "reading" && club_params[:current_book_id].to_i != reading_list_book.book_id
        reading_list_book.update(status: "completed", completed_at: Time.now)
      end
    end
  end
end
