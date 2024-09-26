class BooksController < ApplicationController
  def index
    case params[:search_by]
    when "Genre"
      @books = Book.where("genres LIKE ?", "%#{params[:search_term]}%").page(params[:page])
    when "Author"
      @books = Book.where("author LIKE ?", "%#{params[:search_term]}%").page(params[:page])
    when "Title"
      @books = Book.where("title LIKE ?", "%#{params[:search_term]}%").page(params[:page])
    else
      @books = Book.all.page(params[:page])
    end

    if @books.empty?
      flash.now[:notice] = "No books found"
    end
  end

  def show
    @book = Book.find(params[:id])
  end
end
