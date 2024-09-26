class ReadingListBooksController < ApplicationController
  before_action :require_login
  before_action :set_club
  before_action :set_reading_list_book, only: [ :update ]
  before_action :require_admin, only: [ :destroy ]
  before_action :authorize_club_member

  def create
    @reading_list_book = @club.reading_list_books.build(reading_list_book_params)
    @reading_list_book.added_at = Time.now
    if @reading_list_book.status.blank?
      @reading_list_book.status = "to_read"
    end

    if @club.reading_list_books.exists?(book_id: reading_list_book_params[:book_id])
      redirect_to error_path, alert: "This book is already in the reading list."
    elsif @reading_list_book.save
      redirect_to @club, notice: "Book was successfully added to the reading list."
    else
      redirect_to error_path, alert: "Failed to add book to the reading list: #{@reading_list_book.errors.full_messages.join(", ")}"
    end
  end

  def update
    if @reading_list_book.update(reading_list_book_params)
      redirect_to @club, notice: "Reading list book was successfully updated."
    else
      redirect_to error_path, alert: "Failed to update reading list book."
    end
  end

  def destroy
    if params[:id] == "all"
      @club.reading_list_books.destroy_all
      @club.current_book = nil
      @club.save
      redirect_to @club, notice: "All books were successfully removed from the reading list."
      return
    end

    set_reading_list_book
    @reading_list_book.destroy

    if @reading_list_books == nil || @club.current_book == @reading_list_book
      @club.current_book = nil
      @club.save
    end
    redirect_to @club, notice: "Book was successfully removed from the reading list."
  end

  private

  def set_club
    @club = Club.find(params[:club_id])
  end

  def set_reading_list_book
    @reading_list_book = @club.reading_list_books.find(params[:id])
  end

  def reading_list_book_params
    params.require(:reading_list_book).permit(:book_id, :status)
  end

  def authorize_club_member
    unless @club.users.include?(current_user)
      redirect_to @club, alert: "You must be a member of this club to perform this action."
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
end
