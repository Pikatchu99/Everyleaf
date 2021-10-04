class SessionsController < ApplicationController
    def new
    end
    
    def create
      user = User.find_by(email: params[:session][:email].downcase)
      if user && user.authenticate(params[:session][:password])
        session[:user_id] = user.id
        redirect_to posts_path
      else
        flash[:danger] = "Login Failed"
        render :new
      end
    end
    def destroy
      session.delete(:user_id)
      flash[:notice] = "Deconnecté"
      redirect_to new_session_path
    end
end
