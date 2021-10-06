class Admin::UsersController < ApplicationController
    # before_action :if_login, only: %i[ new ]
    before_action :find_id, only: %i[edit update destroy show]

    def index
        if current_user.is_admin
            @users = User.all.includes(:tasks).page params[:page]
        else
            flash[:danger] = "Only admin can access"
            redirect_to tasks_path
        end
    end

    def new
      @user = User.new
    end
  
    def create
      @user = User.new(user_params)
      if @user.save
        flash[:success] = "User create successfuly"
        redirect_to admin_users_path
      else
        render :new
      end
    end
  
    def show
    end

    def edit
    end

    def update
        @user.skip_validations = true
        if @user.update(user_params)
          flash[:success] = "Profile updated"
          redirect_to admin_users_path
        else
          render :edit
        end
      end

    def destroy
      @user.destroy
      redirect_to admin_users_path, notice:"Admin deleted"
    end


    private

    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation, :is_admin)
    end
    def find_id
        @user = User.find(params[:id])
    end

#   def if_login
#     if current_user.present?
#       flash[:error] = "You are already connected"
#       redirect_to tasks_path
#     end
#   end
end
