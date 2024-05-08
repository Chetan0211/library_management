class UsersController < ApplicationController

    before_action :logged_in, only: [:show, :log_out]

    def sign_up
        if get_logged_in_user.present?
            if get_logged_in_user == "admin"
                redirect_to admin_root_path
                return
            else
                redirect_to root_path
                return
            end
        end
        @user = User.new
    end

    def sign_up_validation
        @user = User.new(user_params)
        if @user.save
            set_logged_in_user("user")
            set_user_id(@user.id)
            redirect_to root_path
        else
            redirect_to root_path
        end
    end

    def show
        @user = User.find(get_user_id)
    end

    def destroy
        @user = User.find(get_user_id)
        @user.destroy
        reset_session
        redirect_to root_path
    end


    def log_out
        reset_session
        redirect_to root_path
    end

    def edit
      @user = User.find(get_user_id)
    end

    def sign_in
        if get_logged_in_user.present?
            if get_logged_in_user == "admin"
                redirect_to admin_root_path
            else
                redirect_to root_path
            end
        end
    end

    def sign_in_validation
        @user = User.find_by(email: params[:email])
        if @user && @user.authenticate(params[:password])
            if @user.is_admin_user
                set_logged_in_user("admin")
                set_user_id(@user.id)
                redirect_to admin_root_path
            else
                set_logged_in_user("user")
                set_user_id(@user.id)
                redirect_to root_path
            end
        else
            render :sign_in, notice: "Can't able to sign in. Sign In with correct credentials."
        end
    end

    private

    def user_params
        params.require(:user).permit(:first_name, :last_name, :email, :password, :password_confirmation)
    end
end
