class ApplicationController < ActionController::Base

    helper_method :is_admin_user, :set_logged_in_user, :get_logged_in_user, :set_user_id, :get_user_id, :logged_in

    def is_admin_user
        if (get_logged_in_user != "admin")
            redirect_to root_path
            return
        end
    end

    def set_logged_in_user(logged_in_user)
        session[:logged_in_user] = logged_in_user
    end

    def get_logged_in_user
        return session[:logged_in_user]
    end

    def set_user_id(user_id)
        session[:user_id] = user_id
    end
    def get_user_id
        return session[:user_id]
    end

    def logged_in
        if !get_logged_in_user.present?
            redirect_to sign_in_path
            return
        end
    end
end
