class HomeController < ApplicationController

    before_action :logged_in

    def index
        @search_text = params[:search_text]
        #debugger
        if params[:search_text].present?
            @books = Book.where("LOWER(name) LIKE LOWER(?)", "%#{params[:search_text]}%")
        else
            @books = Book.all
        end
        
        @requested_books = Borrower.where(user_id: get_user_id, status: [:requested, :active])
    end

    def show
        @book = Book.find(params[:id])
    end

    def request_book
        @barrow_request = Borrower.new(user_id: get_user_id, book_id: params[:id])
        if @barrow_request.save
            @book = Book.find(params[:id])
            if @book.update(available_quantity: @book.available_quantity-1) 
                redirect_to root_path, notice: "#{params[:name]} requested successfully"
            else
                Borrower.destroy(@barrow_request.id)
            end
        else
            render :index, notice: "Can't able to request this book at this time."
        end
    end
end
