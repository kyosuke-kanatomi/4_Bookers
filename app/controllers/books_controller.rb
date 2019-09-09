class BooksController < ApplicationController
  def index
    @books = Book.all.order(id: "DESC")
    @book = Book.new
  end

  def new
    @book = Book.find(params[:id])
  end

  def create
    @book = Book.new(post_params)
    if @book.save
      flash[:notice] = "Book was successfully created."
      redirect_to book_path(@book.id)
    else
      @books = Book.all.order(id: "DESC")
      render("books/index")
    end
  end

  def show
    @book = Book.find(params[:id])
  end

  def edit
    @book = Book.find(params[:id])
  end

  def update
    @book = Book.find(params[:id])
    if @book.update(post_params)
      flash[:notice] = "Book was successfully updated."
      redirect_to book_path(@book.id)
    else
      render("books/edit")
    end
  end

  def destroy
    book = Book.find(params[:id])
    book.destroy
    redirect_to books_path
  end

  private
  def post_params
      params.require(:book).permit(:title, :body)
  end
end
