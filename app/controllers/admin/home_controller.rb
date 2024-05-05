class Admin::HomeController < AdminController
    before_action :is_admin_user

    def index
    end
end