class ReviewsController < ApplicationController
  before_action :require_login
  before_action :set_review, only: [ :show, :edit, :update, :destroy ]
  before_action :authorize_review, only: [ :edit, :update, :destroy ]

  def index
    @book = Book.find(params[:book_id])
    @reviews = @book.reviews
  end

  def show
    @book = @review.book
  end

  def new
    @book = Book.find(params[:book_id])
    @review = @book.reviews.build
  end

  def create
    @book = Book.find(params[:book_id])
    @review = @book.reviews.build(review_params)
    @review.user = current_user

    if @review.save
      redirect_to book_path(@book), notice: "Review was successfully created."
    else
      redirect_to new_book_review_path(@book), alert: "Review could not be created.", status: :unprocessable_entity
    end
  end

  def edit
    @review = Review.find(params[:id])
    @book = @review.book
  end

  def update
    if @review.update(review_params)
      redirect_to book_review_path(@review.book, @review), notice: "Review was successfully updated."
    else
      render :edit
    end
  end

  def destroy
    book = @review.book
    @review.destroy
    redirect_to book_path(book), notice: "Review was successfully deleted."
  end

  private

  def set_review
    @review = Review.find(params[:id])
  end

  def review_params
    params.require(:review).permit(:rating, :review_text)
  end

  def authorize_review
    unless @review.user == current_user || current_user.role == "ADMIN"
      redirect_to book_path(@review.book), alert: "You are not authorized to perform this action."
    end
  end

  def require_login
    unless current_user
      redirect_to login_path, alert: "You must be logged in to access this page."
    end
  end
end
