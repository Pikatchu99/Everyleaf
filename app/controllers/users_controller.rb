class UsersController < ApplicationController
  before_action :if_login, only: %i[ new ]
  before_action :find_id, only: %i[edit update destroy]

  def new
    if current_user.present?
      redirect_to tasks_path
    else
      @user = User.new
    end
  end
  
  def create
    @user = User.new(user_params)
    @user.is_admin = false
    if @user.save
      session[:user_id] = @user.id
      flash[:success] = "Successfully and Already Connected"
      redirect_to @user
    else
      render :new
    end
  end
  
  def show
    if params[:id].to_i != current_user.id && !current_user.is_admin
      flash[:error] = "This is not your page"
      redirect_to tasks_path
    else
      @user = User.find(params[:id])
    end
  end

  
  def edit
    # @user = User.find(params[:id])
  end


  def update
    # @user = User.find(params[:id])
    @user.skip_validations = true
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated"
      if current_user.is_admin
      redirect_to admin_users_path
      else redirect_to tasks_path
      end
    else
      render :edit
    end
  end

  def destroy
    @user.destroy
    redirect_to admin_users_path, notice:"User deleted"
  end
  private
  
  def user_params
    params.require(:user).permit(:name, :email, :password, :password_confirmation)
  end

  def find_id
    @user = User.find(params[:id])
  end

  def if_login
    if current_user.present?
      flash[:error] = "You are already connected"
      redirect_to tasks_path
    end
  end
end
