class Admin::AuthorsController < AdminController

    before_action :is_admin_user

    def index
        @authors = Author.all
    end

    def show
        @show_author = Author.find(params[:id])
    end

    def new
        @new_author = Author.new
    end

    def create
        @new_author = Author.new(author_params)
        if @new_author.save
            redirect_to admin_author_path(@new_author)
        else
            render :new
        end
    end

    def edit
        @edit_author = Author.find(params[:id])
    end

    def update
        @edit_author = Author.find(params[:id])
        if @edit_author.update(author_params)
            redirect_to admin_author_path(@edit_author)
        else
            render :edit
        end
    end

    def destroy
        @delete_author = Author.find(params[:id])
        @delete_author.destroy
    end

    private

    def author_params
        params.require(:author).permit(:name)
    end

end
