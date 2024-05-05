class Admin::BooksController < AdminController
    
    before_action :is_admin_user

    def index
        @search_text = params[:search_text]
        if !@search_text.blank?
            @books = Book.where("LOWER(name) LIKE LOWER(?)", "%#{@search_text}%")
        else
            @books = Book.all
        end
    end

    def show
        @book = Book.find(params[:id])
    end

    def new
        @book = Book.new
        @authors = Author.all
    end

    def create
        @book = Book.new(book_params)
        if @book.save
            redirect_to admin_book_path(@book)
        else
            render 'new'
        end
    end

    def edit
        @book = Book.find(params[:id])
        @authors = Author.all
    end

    def update
        @book = Book.find(params[:id])
        if @book.update(book_params)
            redirect_to admin_book_path(@book)
        else
            render 'edit'
        end
    end

    def destroy
        @book = Book.find(params[:id])
        @book.destroy
    end

    private

    def book_params
        params.require(:book).permit(:name, :price, :available_quantity, :total_quantity, :author_id)
    end
end
