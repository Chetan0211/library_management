class Admin::UsersController < AdminController
    before_action :is_admin_user


    def new
        @new_user = User.new
    end

    def create
        @new_user = User.new(user_params)
        if @new_user.save
            redirect_to admin_user_path(@new_user)
        else
            render :new
        end
    end

    def index
        @all_users = User.all
    end

    def show
        @show_user = User.find(params[:id])
    end

    def edit
        @edit_user = User.find(params[:id])
    end

    def update
        @edit_user = User.find(params[:id])
        if @edit_user.update(user_params)
            redirect_to admin_user_path(@edit_user)
        else
            render :edit
        end
    end

    def destroy
        @delete_user = User.find(params[:id])
        @delete_user.destroy
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation, :is_admin_user)
    end
    
end