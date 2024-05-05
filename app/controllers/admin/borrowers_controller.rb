class Admin::BorrowersController < AdminController

    before_action :is_admin_user

    def index
        #debugger
        @search_text = params[:search_text]
        if !@search_text.blank?
            @borrowers = Borrower.includes(:book).references(:book).includes(:user).references(:user).where("LOWER(books.name) LIKE LOWER(?) OR LOWER(users.first_name) LIKE LOWER(?) OR LOWER(users.last_name) LIKE LOWER(?)", "%#{@search_text}%", "%#{@search_text}%", "%#{@search_text}%")
        else
            @borrowers = Borrower.includes(:book).references(:book).includes(:user).references(:user)
        end
        
    end
    
    def show
        @borrower = Borrower.find(params[:id])
    end

    def new
        @borrower = Borrower.new
        @books = Book.all
        @users = User.all
    end

    def create
        b_params = borrower_params
        @book = Book.find(b_params[:book_id])
        if (@book.present? && @book.available_quantity > 0)
            @borrower = Borrower.new(borrower_params)
            if @borrower.save
                @book.update(available_quantity: @book.available_quantity-1)
                redirect_to admin_borrower_path(@borrower)
            end
        else
            redirect_to new_admin_borrower_path, notice: "Selected book is not available"
        end

        
    end

    def edit
        @borrower = Borrower.find(params[:id])
    end

    def update
        @borrower = Borrower.find(params[:id])
        prev_status = @borrower.status
        if @borrower.update(borrower_params)
            if((@borrower.status == "returned" || @borrower.status == "rejected") && (prev_status != "returned" || prev_status != "rejected"))
                @book = Book.find(@borrower.book_id)
                @book.update(available_quantity: @book.available_quantity+1)
            elsif((prev_status != "active") && (prev_status != "requested"))
                @book = Book.find(@borrower.book_id)
                @book.update(available_quantity: @book.available_quantity-1)
            end
            redirect_to admin_borrower_path(@borrower)
        else
            render :edit
        end
    end

    def destroy
        @borrower = Borrower.find(params[:id])
        @borrower.destroy
    end

    private

    def borrower_params
        params.require(:borrower).permit(:book_id, :user_id, :status)
    end
end
